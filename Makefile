COMPOSE_FILE := compose-dev.yml
DOCKER_COMPOSE := docker compose -f $(COMPOSE_FILE)

include .env

.PHONY: down up populate release

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
	(cd $(ROOKERY_COMMANDS_REPO) && git status)
	(cd $(ROOKERY_VIEWS_REPO) && git status)
	(cd $(ROOKERY_SAGAS_REPO) && git status)
	(cd $(ROOKERY_UI_REPO) && git status)
	git status

federation-test:
	sh scripts/federation-test.sh

