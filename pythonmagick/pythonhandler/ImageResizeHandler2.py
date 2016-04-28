import os

from ImgLogger import ImgLogger as Logger
from ImgReqPaser import ImgReqPaser
from ImgResizer import ImgResizerFactory, Status
from mod_python import apache

logger = Logger()
req_paser=ImgReqPaser()
# http://modpython.org/live/current/modpython.pdf
  
def process_result(req, targetfile, mtime=None):
    if not mtime:
        mtime = os.stat(targetfile).st_mtime
    req.update_mtime(mtime)
    req.set_last_modified()
    http_status = req.meets_conditions()
    logger.log_info("http meets conditions, status is %s, mtime is %s" % (http_status, mtime))
    if(http_status == apache.OK):
        req.sendfile(targetfile)
    return int(http_status)
 
def handler(req):
    # req.content_type='text/plain'
    req.content_type = 'image/jpeg'
    # if not resizer:
    resizer = ImgResizerFactory.get_instance(req)
    (is_resize_file, src_file, tar_file, width, height) = req_paser.retrive_resizefile_info(req, req.uri)
      
    if is_resize_file:
        result = resizer.resize(src_file, tar_file, width, height)
          
        if result.status == Status.TARGET_NOTMODIFY or  result.status == Status.SUCESS :
            logger.log_info("target file not modify")
            return process_result(req, result.filepath, result.mtime)
          
        if result.status == Status.ERROR:
            req.log_error(str(result.messages))
            return apache.HTTP_SERVICE_UNAVAILABLE
        if result.status == Status.SRC_NOTFOUNT:
            return apache.HTTP_NOT_FOUND
    else:
        file_path = req.document_root() + req.uri
        logger.log_info("File %s is not a runtime resized file" % file_path)
        if os.path.exists(file_path):
            return process_result(req, file_path)
        else:
            logger.log_info("File %s not found, please check configuration and FILE MODE" % file_path)
           
    return apache.HTTP_NOT_FOUND


