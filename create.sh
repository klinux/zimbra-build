docker run --rm --name "zimbra-build-rockylinux8" \
-v $PWD/volume:/home/git/zimbra/BUILDS \
-v $PWD/ssh:/root/.ssh \
-e BUILD_NO="0002" \
-e BUILD_RELEASE="DAFFODIL" \
-e BUILD_RELEASE_NO="10.0.1" \
-e BUILD_OS="RHEL8_64" \
-e BUILD_ARCH="amd64" \
-e BUILD_TYPE="FOSS" \
-e PKG_OS_TAG="r8" \
-e BUILD_RELEASE_CANDIDATE="GA" \
-e BUILD_THIRDPARTY_SERVER="files.zimbra.com" \
-e INTERACTIVE="0" \
rockylinux8-zm-build

