#!/bin/bash
_includeFile=$(type -p overrides.inc)
if [ ! -z ${_includeFile} ]; then
  . ${_includeFile}
else
  _red='\033[0;31m'; _yellow='\033[1;33m'; _nc='\033[0m'; echo -e \\n"${_red}overrides.inc could not be found on the path.${_nc}\n${_yellow}Please ensure the openshift-developer-tools are installed on and registered on your path.${_nc}\n${_yellow}https://github.com/BCDevOps/openshift-developer-tools${_nc}"; exit 1;
fi

OUTPUT_FORMAT=json

# Generate application config map
# - To include all of the files in the application instance's profile directory.
# Injected by genDepls.sh
# - MATOMO_CONFIG_MAP_NAME

# Generate the config map ...
MATOMO_CONFIG_SOURCE_PATH=$( dirname "$0" )/config
CONFIGMAP_OUTPUT_FILE=${MATOMO_CONFIG_MAP_NAME}-configmap_DeploymentConfig.json
printStatusMsg "Generating ConfigMap; ${MATOMO_CONFIG_MAP_NAME} ..."
generateConfigMap "${MATOMO_CONFIG_MAP_NAME}" "${MATOMO_CONFIG_SOURCE_PATH}" "${OUTPUT_FORMAT}" "${CONFIGMAP_OUTPUT_FILE}"

unset SPECIALDEPLOYPARMS
echo ${SPECIALDEPLOYPARMS}