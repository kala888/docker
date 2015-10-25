#!/bin/bash

echo "starting Platform service..."
/bin/sh -c "/opt/endeca/PlatformServices/11.1.0/tools/server/bin/startup.sh"
sleep 1s

echo "starting Workbench..."
/bin/sh -c "/opt/endeca/ToolsAndFrameworks/11.1.0/server/bin/startup.sh"

echo "starting CAS..."
/bin/sh -c "nohup /opt/endeca/CAS/11.1.0/bin/cas-service.sh < /dev/null > /opt/endeca/CAS/workspace/logs/cas-service-wrapper.log & "

