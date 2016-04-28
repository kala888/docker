from mod_python import apache

class ImgLogger():
    """
    Global logger, the message will save to apache error files
    """
    def __init__(self, loggingInfo=False, loggingError=False):
        self.loggingInfo = loggingInfo
        self.loggingError = loggingError
        
    def log_info(self, obj):
        if self.loggingInfo:
            apache.log_error("info:" + str(obj))
            
    def log_error(self, obj):
        if self.loggingError:
            apache.log_error(obj)
