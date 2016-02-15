export ROOT=$(realpath $(dir $(lastword $(MAKEFILE_LIST))))
export DOCKER=$(shell which docker)

all: build

build: pre
	$(DOCKER) run -v $(ROOT)/tmp:/build gerrit-builder

pre:
	cd $(ROOT)/build && $(DOCKER) build -t gerrit-builder .
	

