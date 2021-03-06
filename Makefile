SHELL=env bash

SUPPORTED_COMMANDS := bundle run

SUPPORTS_MAKE_ARGS := $(findstring $(firstword $(MAKECMDGOALS)), $(SUPPORTED_COMMANDS))
ifneq "$(SUPPORTS_MAKE_ARGS)" ""
  COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(COMMAND_ARGS):;@:)
endif

install: ## Install dependencies
	@docker-compose run --rm --entrypoint bundle ruby install --deployment

bundle: ## Run a bundle command
	@docker-compose run --rm --entrypoint bundle ruby $(COMMAND_ARGS)

run: ## Anonymize a database
	@docker-compose run --rm --entrypoint bundle ruby exec rake project:anonymize[$(COMMAND_ARGS)]

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
