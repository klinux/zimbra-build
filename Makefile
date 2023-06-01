SRC=$(shell pwd)

.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

.PHONY: build
build: ## Compila o Zimbra
	mkdir ssh || true
	mkdir volume || true
	ssh-keygen -t rsa -b 4096 -C "example@example.com" -f $$PWD/ssh/id_rsa
	docker build -t rockylinux8-zm-build .
	docker run --rm --name "zimbra-build-rockylinux8" \
	-v $$PWD/volume2:/home/git/zimbra/BUILDS \
	-v $$PWD/ssh2:/root/.ssh \
	-e BUILD_NO="$$BUILD_NO" \
	-e BUILD_RELEASE="DAFFODIL" \
	-e BUILD_RELEASE_NO="$$BUILD_RELEASE_NO" \
	-e BUILD_OS="RHEL8_64" \
	-e BUILD_ARCH="amd64" \
	-e BUILD_TYPE="FOSS" \
	-e PKG_OS_TAG="r8" \
	-e BUILD_RELEASE_CANDIDATE="GA" \
	-e BUILD_THIRDPARTY_SERVER="files.zimbra.com" \
	-e INTERACTIVE="0" \
	rockylinux8-zm-build
