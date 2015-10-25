#!/bin/bash
#stop platformservice
/bin/sh -c "/opt/endeca/PlatformServices/6.1.4/tools/server/bin/shutdown.sh"
#stop toolsandframeworks
/bin/sh -c "/opt/endeca/ToolsAndFrameworks/3.1.2/server/bin/shutdown.sh"
#stop cas
/bin/sh -c "/opt/endeca/CAS/3.1.2.1/bin/cas-service-shutdown.sh"
