#!/usr/bin/env bash
set -e
set -o pipefail

##
# Install the latest stable release of CesiumJS
#
CESIUM_VERSION=1.83
mkdir -p /tmp/cesium /var/www/cesium || exit 1
cd /tmp/cesium || exit 1

# Get Cesium if we need to
if [ ! -f /tmp/local/Cesium-${CESIUM_VERSION}.zip ]; then
    wget --no-verbose  --directory-prefix=/tmp/local https://github.com/CesiumGS/cesium/releases/download/${CESIUM_VERSION}/Cesium-${CESIUM_VERSION}.zip || exit 1
fi

unzip -q /tmp/local/Cesium-${CESIUM_VERSION}.zip || exit 1
mv Apps ThirdParty Build /var/www/cesium/ || exit 1
