#!/bin/bash
FILE_TO_GEN='310-nginxConfigMap.yml'

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Get the directory of the current script
script_dir="$(dirname "$(realpath "$BASH_SOURCE")")"

if command -v kubectl >/dev/null 2>&1; then
    echo -e "${GREEN} [$(date +"%Y-%m-%d %H:%M:%S")] ### ✅ kubectl is installed ${NC}"
else
    echo -e "${RED} [$(date +"%Y-%m-%d %H:%M:%S")] ### ERROR❌: kubectl is not installed${NC}" >&2
    exit 1
fi
echo -e " [$(date +"%Y-%m-%d %H:%M:%S")] ###  Gernerate configuration for nginx from local device"

kubectl create configmap nginx-config --from-file=$script_dir/../nginx_conf --dry-run=client -o yaml > $script_dir/../$FILE_TO_GEN

if [ $? -eq 0 ]; then
    echo -e "${GREEN} [$(date +"%Y-%m-%d %H:%M:%S")] ### ✅ Gernerate configuration for nginx from local device has been successful completly"
    echo -e "${GREEN} [$(date +"%Y-%m-%d %H:%M:%S")] ### Generated file: ${FILE_TO_GEN} ${NC}"
else
    echo -e "${RED} [$(date +"%Y-%m-%d %H:%M:%S")] ### ERROR❌: Gernerate configuration for nginx has fail  ### ${NC} "
fi
