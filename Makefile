export ROOT=$(realpath $(dir $(lastword $(MAKEFILE_LIST))))
export DOCKER=$(shell which docker)
export DOCKER_BUILD=$(ROOT)/tmp/docker-build
all: build

build: pre
	$(DOCKER) run --rm -v $(ROOT)/tmp:/build gerrit-builder
	rm -rf $(DOCKER_BUILD)
	mkdir -p $(DOCKER_BUILD)/plugins
	cp $(ROOT)/tmp/gerrit/buck-out/gen/gerrit/gerrit.war $(DOCKER_BUILD)
	cp $(ROOT)/tmp/gerrit/buck-out/gen/plugins/gitiles/gitiles/gitiles.jar $(DOCKER_BUILD)/plugins
	cp $(ROOT)/tmp/gerrit/buck-out/gen/plugins/admin-console/admin-console.jar $(DOCKER_BUILD)/plugins
	cp $(ROOT)/tmp/gerrit/buck-out/gen/plugins/avatars-gravatar/avatars-gravatar.jar $(DOCKER_BUILD)/plugins
	cp $(ROOT)/tmp/gerrit/buck-out/gen/plugins/branch-network/branch-network.jar $(DOCKER_BUILD)/plugins
	cp $(ROOT)/tmp/gerrit/buck-out/gen/plugins/commit-message-length-validator/commit-message-length-validator.jar $(DOCKER_BUILD)/plugins
	cp $(ROOT)/tmp/gerrit/buck-out/gen/plugins/delete-project/delete-project.jar $(DOCKER_BUILD)/plugins
	cp $(ROOT)/tmp/gerrit/buck-out/gen/plugins/download-commands/download-commands.jar $(DOCKER_BUILD)/plugins
	cp $(ROOT)/tmp/gerrit/buck-out/gen/plugins/gerrit-oauth-provider/gerrit-oauth-provider.jar $(DOCKER_BUILD)/plugins
	cp $(ROOT)/tmp/gerrit/buck-out/gen/plugins/plugin-manager/plugin-manager.jar $(DOCKER_BUILD)/plugins
	cp $(ROOT)/tmp/gerrit/buck-out/gen/plugins/replication/replication.jar $(DOCKER_BUILD)/plugins
	cp $(ROOT)/tmp/gerrit/buck-out/gen/plugins/reviewnotes/reviewnotes.jar $(DOCKER_BUILD)/plugins
	cp $(ROOT)/tmp/gerrit/buck-out/gen/plugins/singleusergroup/singleusergroup.jar $(DOCKER_BUILD)/plugins
	
pre:
	cd $(ROOT)/builder && $(DOCKER) build -t gerrit-builder .
	


