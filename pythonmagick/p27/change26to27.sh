#!/bin/bash
# yum should use python2.6
cd /usr/bin
rm -rf python
ln -s /usr/local/python2.7/bin/python
cat /usr/bin/yum|sed 's/\/usr\/bin\/python/\/usr\/bin\/python2.6/' > yum.tmp
cat yum.tmp >/usr/bin/yum
rm -rf yum.tmp