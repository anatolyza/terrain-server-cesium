#!/usr/bin/env bash
set -e
set -o pipefail

##
# Install the terrain server
#

# not sure why I need to do this again, it's exported in install go
export PATH=$GOBIN:$PATH

# If a local source code archive does not exist, get it from GitHub.
archive="/tmp/local/cesium-terrain-server-${FRIENDLY_CHECKOUT}.tar.gz"
if [ ! -f $archive ]; then
	echo !!!! Downloading Archive Local not Found !!!!!
#	wget --no-verbose -O $archive "https://github.com/anatolyza/terrain-server-cesium/archive/master.tar.gz"
        git clone -b go1-21-11 https://github.com/anatolyza/terrain-server-cesium.git $archive
fi

if [[ -z $GOPATH ]]; then
	GOPATH=$GOROOT
fi
# Set up the source directory
CTS_DIR=$GOPATH/src/github.com/anatolyza/terrain-server-cesium
mkdir -p $CTS_DIR
echo made src/github/cst_dir
cd $CTS_DIR
echo "!!! in CTS_DIR !!!"

# Extract the terrain server code
#tar --strip-components=1 -xzf $archive
#echo "!!! untared archive !!!"
echo PATH: $PATH
# Build and install the server
cd $archive
make install
# echo "!!! sucessful install !!!"
