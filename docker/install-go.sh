#!/bin/sh
##
# Install the latest stable release of Go
#
# See <https://go.dev/dl/>
#

cd /tmp 
curl -OL https://go.dev/dl/go1.23.8.linux-amd64.tar.gz
tar -C /usr/local -xvf go1.23.8.linux-amd64.tar.gz
ln -s /usr/local/go/bin/go* /usr/local/bin/ 
rm -rf /tmp/go1.23.8.linux-amd64.tar.gz
