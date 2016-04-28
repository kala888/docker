import re
from ImgLogger import ImgLogger as Logger


class ImgReqPaser():
    
    def __init__(self, reg="(.*)_(\w*)\.(jpg|png|jpeg)"):
        self.reg = reg
        self.comp = re.compile(reg)
        self.size_comp = re.compile("(\d+)(x|X)(\d+)")
        self.logger = Logger()
    
    def __retrive_size(self, str_size):
        match = self.size_comp.match(str_size)
        if match  and len(match.group()) > 3:
            return (int(match.group(1)), int(match.group(3)))
        return (None, None)
        
    def retrive_resizefile_info(self, req, req_filepath):
        is_resize_file = False
        tar_file = req_filepath
        src_file = req_filepath
        width = None
        height = None
        
        match = self.comp.match(req_filepath)
        if match  and len(match.group()) > 3:
            tar_file = req_filepath
            file_posfix = match.group(3)
            key = match.group(2);
            size_str = req.get_options().get(key)
            if not size_str:
                self.logger.log_error("size str %s" % size_str)
            else:
                (width, height) = self.__retrive_size(size_str)
                src_file = match.group(1) + "." + file_posfix               
            is_resize_file = True
#             if not size_str:
#                 size_str=req.get_options().get("default")
#                 tar_file="%s_%s.%s"%(match.group(1) , "default",file_posfix)
        if not width:
            is_resize_file = False
        return (is_resize_file, src_file, tar_file, width, height)

    
#     def __init__(self, reg="(.*)_(\d+)(x|X)(\d+)\.(jpg|png|jpeg)"):
#         self.reg = reg
#         self.comp = re.compile(reg)
#         
#     def retrive_resizefile_info(self, req_filepath):
#         is_resize_file = False
#         tar_file = req_filepath
#         src_file = req_filepath
#         width = 0
#         height = 0
#         
#         match = self.comp.match(req_filepath)
#         if match  and len(match.group()) > 5:
#             is_resize_file = True
#             tar_file = req_filepath
#             width = int(match.group(2))
#             height = int(match.group(4))
#             file_posfix = match.group(5)
#             src_file = match.group(1) + "." + file_posfix
#         return (is_resize_file, src_file, tar_file, width, height)
