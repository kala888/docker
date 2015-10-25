package Apache::DockerCacheHandler;
# file: Apache/DockerCacheHandler.pm
# --------------------------------------------------------------------------------------------
#  Author: Aaxis Commerce
# Contact: kalaliu@aaxisgroup.com
#    Date: 09/22/2015
# Purpose: Cache the docker files, used by docker developer.
# help doc:http://blog.sina.com.cn/s/blog_6294abe70101b4fc.html
# --------------------------------------------------------------------------------------------
use Apache2::RequestRec();
use Apache2::RequestIO ();
use Apache2::Const -compile => qw(:common REDIRECT HTTP_NO_CONTENT DIR_MAGIC_TYPE HTTP_NOT_MODIFIED);
use DirHandle ();
use Apache2::Log ();
use Apache2::RequestUtil ();
use File::Path qw(mkpath);
use APR::Table ();

sub downloadfiles {
    my $r=$_[0];
    my $remote_server=$r->dir_config('remote_server');
    my $uri=$r->unparsed_uri;
    my $scaledFilePath = "/var/www/html/$uri";
    $cmd="var_temp=\"$scaledFilePath\" && mkdir -p \${var_temp%/*} && wget -qO $scaledFilePath $remote_server$uri && chmod -R  755 /var/www/html/docker/apps";
    $r->log_error("This is not an error just show a message: $cmd");
    system("$cmd");
 return $scaledFilePath;
}

sub handler {
    my $r = shift;
    # get the name of the requested file
    my $file = $r->filename;
    return OK if $r->header_only;
    if (-r $file) { # file exists, so it becomes the source
       $source = $file;
    }else {              # file doesn't exist, so we search for it
       $source =downloadfiles($r);
    }
    $r->sendfile($source);
    return OK;
}

1;
