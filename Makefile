COMPOSE_FILE := compose-dev.yml
DOCKER_COMPOSE := docker compose -f $(COMPOSE_FILE)

include .env

.PHONY: down up populate release federation-test status tag

federation-test:
	sh test/federation-test.sh

up: build
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down -v

build:
	$(DOCKER_COMPOSE) build

populate:
	sh scripts/create-test-data.sh

release: down
	$(MAKE) -C $(ROOKERY_COMMANDS_REPO) all release
	$(MAKE) -C $(ROOKERY_VIEWS_REPO) all release
	$(MAKE) -C $(ROOKERY_SAGAS_REPO) all release
	$(MAKE) -C $(ROOKERY_UI_REPO) all release

status:
	(cd $(ROOKERY_COMMANDS_REPO) && git describe --tags && git status -s && echo)
	(cd $(ROOKERY_VIEWS_REPO) && git describe --tags && git status -s && echo)
	(cd $(ROOKERY_SAGAS_REPO) && git describe --tags && git status -s && echo)
	(cd $(ROOKERY_UI_REPO) && git describe --tags && git status -s && echo)
	git status -s

tag:
	(cd $(ROOKERY_COMMANDS_REPO) && git tag ${VERSION})
	(cd $(ROOKERY_VIEWS_REPO) && git tag ${VERSION})
	(cd $(ROOKERY_SAGAS_REPO) && git tag ${VERSION})
	(cd $(ROOKERY_UI_REPO) && git tag ${VERSION})

