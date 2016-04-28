from __future__ import division 

from abc import ABCMeta, abstractmethod
import os
from wand.color import Color
from wand.image import Image

from ImgLogger import ImgLogger as Logger


logger = Logger()

class Status():
    """
    A DTO for resized file
    """
    ERROR = 0
    SRC_NOTFOUNT = 1
    TARGET_NOTMODIFY = 2
    SUCESS = 3
    def __init__(self, status, filepath=None, msg=None, mtime=0.0):
        self.status = status
        self.filepath = filepath
        self.mtime = mtime
        self.messages = []
        if  msg:
            self.messages.append(msg)
        
    def addmsg(self, msg):
        self.messages.append(msg)
        
class ImgResizerFactory():
    instance= None
    @staticmethod
    def get_instance(req):
        #return CompositeResizer(req.document_root())
        if not ImgResizerFactory.instance:
            ImgResizerFactory.instance=CompositeResizer(req.document_root())
            # resizer=SampleResizer(req.document_root())
        return ImgResizerFactory.instance
        
class AbstactResizer():
    """
    Abstract class for Resizer,
    doc_root hold all the resource file,default value is /var/www/html/
    output hold all resized images ,default value is /var/www/html/output/
    """
    __metaclass__ = ABCMeta
    
    def __init__(self, doc_root, output=None):
        self.doc_root = doc_root
        if output:
            self.output = output
        else:
            self.output = doc_root + "/output"
    
    @abstractmethod
    def _resize_img(self, src_width, src_height, tar_width, tar_height):pass

    def resize(self, source_file, target_file, width, height):
        """
        A template method for image resize, if the source file was modified, the target file will re-build.
        """
        sourcefile = self.doc_root + source_file
        targetfile = self.output + target_file
        
        try:
            if not os.path.exists(sourcefile):
                return Status(Status.SRC_NOTFOUNT)
             
            # 1.When target file not exists, the resized image will be created  
            if not os.path.exists(targetfile):
                logger.log_info("target file %s not found, need to resize" % targetfile)
                
                try:
                    parent_folder = os.path.dirname(targetfile)
                    if not os.path.exists(parent_folder):
                        os.makedirs(parent_folder, 0755)
                except IOError, e:
                    logger.log_error("Folder %s not found, this folder need to be created by manual or change owner for  s% to apache and chmod 755" % (parent_folder, self.output))
                    return Status(Status.ERROR, msg=e)
                
                filepath = self._resize_img(sourcefile, targetfile, width, height)
                return  Status(Status.SUCESS, filepath=filepath, mtime=os.stat(filepath).st_mtime)
            
            # 2.When  the modify date of source file is bigger then target file, the target file need to be re-builded, otherwise don't need to do resize
            source_mtime = os.stat(sourcefile).st_mtime
            target_mtime = os.stat(targetfile).st_mtime
            if  (source_mtime - target_mtime) > 0:
                logger.log_info("source file %s was modified" % sourcefile)
                filepath = self._resize_img(sourcefile, targetfile, width, height)
                return  Status(Status.SUCESS, filepath=filepath, mtime=os.stat(targetfile).st_mtime)
            else:
                logger.log_info("source file %s not changed and target file %s is newer than source file, not modify" % (sourcefile, targetfile))
                return Status(Status.TARGET_NOTMODIFY, filepath=targetfile, mtime=target_mtime)
            
        except IOError, e:
            return Status(Status.ERROR, msg=e)
             
       
class SampleResizer(AbstactResizer):
    """
    Resizes the image by sampling the pixels. Its basically quicker than resize() except less quality as a tradeoff.
    """
    def __init__(self, doc_root, output=None):
        AbstactResizer.__init__(self, doc_root, output)
         
    def _resize_img(self, sourcefile, targetfile, width, height):
        with Image(filename=sourcefile) as src_file:
            src_file.sample(width, height)
            src_file.save(filename=targetfile)
        
class CompositeResizer(AbstactResizer):
    """
    Places the supplied image over a empty image with  background color, the image will be placed in center, so there maybe some border in the resized image
    eg. src img size is (600x800)  ==>resize to (300x200), 
    after resize, you will get a image which size is (300x200),but there are some border in that image, the center pic size is (150x200)
    """
    def __init__(self, doc_root, output=None, default_back_color="srgb(255,255,255)"):
        AbstactResizer.__init__(self, doc_root, output=None)
        if default_back_color:
            self.default_back_color = Color(default_back_color)
        # self.conf_back_color_detect = True;
        # self.detection_point = "5,125"; # Only used if resizing

    def __real_size(self, src_width, src_height, tar_width, tar_height):
        """
            The smallest side is the max resize rate.
            when default_back_color not defined as None or target width and height have the same scale rate, set with_border=false
            otherwise return a tuple, with_border=True,new_width and new_height is the image size, pos_left and pos_top will be used by composite
        """
        new_width = tar_width
        new_height = tar_height
        with_border = False
        pos_left = 0
        pos_top = 0
        if self.default_back_color:
            w_rate = round(tar_width / src_width, 2)
            h_rate = round(tar_height / src_height, 2)
            if w_rate != h_rate:
                with_border = True
                # print "w_rate %s,h_rate %s"%(w_rate,h_rate)
                if h_rate < w_rate :
                    new_width = h_rate * src_width
                    pos_left = int(abs(tar_width - new_width) / 2)
                else:
                    new_height = w_rate * src_height
                    pos_top = int(abs(tar_height - new_height) / 2)
        return (with_border, new_width, new_height, pos_left, pos_top)
    
    def _resize_img(self, sourcefile, targetfile, width, height):
        """
        Resize the img with back ground
        """
        with Image(filename=sourcefile) as src_img:
            (with_border, new_width, new_height, pos_left, pos_top) = self.__real_size(*src_img.size, tar_width=width, tar_height=height)
            print  width, height, with_border, new_width, new_height, pos_left, pos_top
            if not with_border:
                src_img.resize(width, height)
                src_img.save(filename=targetfile)
            else:
                with src_img.clone() as tmp_img:
                    tmp_img.resize(int(new_width), int(new_height))
                    with Image(width=width, height=height, background=self.default_back_color) as bg:
                        bg.composite(tmp_img, pos_left, pos_top)
                        # tar_img.gravity = "center"
                        bg.save(filename=targetfile)
        return targetfile

                
if __name__ == '__main__':
    # resizer = SampleResizer("/var/www/html/test/")
    # resizer.resize("rose.jpg", "rose_1.jpg", 1000, 300)
    resizer = CompositeResizer("/var/www/html/test/", default_back_color="srgb(70,80,90)")
    # resizer.resize("rose.jpg", "rose_1.jpg", 1000, 300)
    resizer.resize("rose.jpg", "rose_1.jpg", 900, 601)
