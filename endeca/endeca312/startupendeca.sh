#!/bin/bash
echo "starting Platform service..."
/bin/sh -c "/opt/endeca/PlatformServices/6.1.4/tools/server/bin/startup.sh"
sleep 1s

echo "starting Workbench..."
/bin/sh -c "/opt/endeca/ToolsAndFrameworks/3.1.2/server/bin/startup.sh"

echo "starting CAS..."
/bin/sh -c "nohup /opt/endeca/CAS/3.1.2.1/bin/cas-service.sh < /dev/null > /opt/endeca/CAS/workspace/logs/cas-service-wrapper.log & "

