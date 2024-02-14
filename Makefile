COMPOSE_FILE := compose-dev.yml
DOCKER_COMPOSE := docker compose -f $(COMPOSE_FILE)

.PHONY: down up

up: down build
	$(DOCKER_COMPOSE) up -d

down:
	$(DOCKER_COMPOSE) down -v

build:
	$(DOCKER_COMPOSE) build

