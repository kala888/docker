#!/bin/bash
#stop platformservice
/bin/sh -c "/opt/endeca/PlatformServices/11.1.0/tools/server/bin/shutdown.sh"
#stop toolsandframeworks
/bin/sh -c "/opt/endeca/ToolsAndFrameworks/11.1.0/server/bin/shutdown.sh"
#stop cas
/bin/sh -c "/opt/endeca/CAS/11.1.0/bin/cas-service-shutdown.sh"
