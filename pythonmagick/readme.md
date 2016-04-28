eg.http://trac.openscenegraph.org/projects/osg//wiki/TracModPython

1.
LoadModule python_module modules/mod_python.so

2.
<Location /images>
    SetHandler mod_python
    PythonPath "sys.path + ['/etc/httpd/pythonhandler']" 
    PythonHandler ImageResizeHandler.py
    PythonDebug On
    PythonOption TracEnv /var/trac/myproject
    PythonOption TracUriRoot /projects/myprojec
</Location>