#!/bin/bash

## Vars
BUILD_HOME="/home/git/zimbra"

## Clone do codigo fonte
git clone https://github.com/Zimbra/zm-build.git

## Git Checkout
git checkout origin/develop

## Patch para rockylinux e no store
patch $BUILD_HOME/zm-build/rpmconf/Build/get_plat_tag.sh zimbra-rocky.patch
patch $BUILD_HOME/zm-build/instructions/bundling-scripts/zimbra-store.sh zimbra-store.patch

## Preparando a config
cat > $BUILD_HOME/zm-build/config.build << EOF
BUILD_TS=$(date +%Y%m%d%H%M%S)
BUILD_NO=$BUILD_NO
BUILD_RELEASE=$BUILD_RELEASE
BUILD_RELEASE_NO=$BUILD_RELEASE_NO
BUILD_OS=$BUILD_OS
BUILD_ARCH=$BUILD_ARCH
BUILD_TYPE=$BUILD_TYPE
PKG_OS_TAG=$PKG_OS_TAG
BUILD_RELEASE_CANDIDATE=$BUILD_RELEASE_CANDIDATE
BUILD_THIRDPARTY_SERVER=$BUILD_THIRDPARTY_SERVER
INTERACTIVE=$INTERACTIVE
EOF

## Build
cd $BUILD_HOME/zm-build
/usr/bin/perl build.pl --ant-options -DskipTests=true

