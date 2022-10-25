# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

APP = portefaix

BANNER = P O R T E F A I X / D O C

CONFIG_HOME = $(or ${XDG_CONFIG_HOME},${XDG_CONFIG_HOME},${HOME}/.config)

DEBUG ?=

SHELL = /bin/bash -o pipefail

IMAGE_REGISTRY  = portefaix
CONTAINER_IMAGE = $(IMAGE_REGISTRY)/portefaix-doc
CONTAINER_RUN   = docker run --rm --interactive --tty --volume $(CURDIR):/src
DOCS_ARCHIVE    = public.zip

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))

NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m
INFO_COLOR=\033[36m
WHITE_COLOR=\033[1m

MAKE_COLOR=\033[33;01m%-20s\033[0m

.DEFAULT_GOAL := help

OK=[✅]
KO=[❌]
WARN=[⚠️]

.PHONY: help
help:
	@echo -e "$(OK_COLOR)                  $(BANNER)$(NO_COLOR)"
	@echo "------------------------------------------------------------------"
	@echo ""
	@echo -e "${ERROR_COLOR}Usage${NO_COLOR}: make ${INFO_COLOR}<target>${NO_COLOR}"
	@awk 'BEGIN {FS = ":.*##"; } /^[a-zA-Z_-]+:.*?##/ { printf "  ${INFO_COLOR}%-25s${NO_COLOR} %s\n", $$1, $$2 } /^##@/ { printf "\n${WHITE_COLOR}%s${NO_COLOR}\n", substr($$0, 5) } ' $(MAKEFILE_LIST)



# @echo -e "${ERROR_COLOR}Environments${NO_COLOR}: $(ENVS)"
# @echo ""

guard-%:
	@if [ "${${*}}" = "" ]; then \
		echo -e "$(ERROR_COLOR)Environment variable $* not set$(NO_COLOR)"; \
		exit 1; \
	fi

check-%:
	@if $$(hash $* 2> /dev/null); then \
		echo -e "$(OK_COLOR)$(OK)$(NO_COLOR) $*"; \
	else \
		echo -e "$(ERROR_COLOR)$(KO)$(NO_COLOR) $*"; \
	fi

print-%:
	@if [ "${$*}" == "" ]; then \
		echo -e "$(ERROR_COLOR)[KO]$(NO_COLOR) $* = ${$*}"; \
	else \
		echo -e "$(OK_COLOR)[OK]$(NO_COLOR) $* = ${$*}"; \
	fi

# ====================================
# D E V E L O P M E N T
# ====================================

##@ Development

.PHONY: clean
clean: ## Cleanup
	@echo -e "$(OK_COLOR)[$(BANNER)] Cleanup$(NO_COLOR)"
	@rm -rf public resources node_modules public.zip

.PHONY: check
check: check-konstraint ## Check requirements

.PHONY: diagrams
diagrams: guard-CLOUD_PROVIDER guard-OUTPUT ## Generate diagrams
	@poetry run python3 diagrams/kubernetes.py --output=$(OUTPUT) --cloud=$(CLOUD_PROVIDER) \
		&& mv *.$(OUTPUT) docs/img \
		&& poetry run python3 diagrams/portefaix.py --output=$(OUTPUT) --cloud=$(CLOUD_PROVIDER) \
		&& mv *.$(OUTPUT) docs/img

.PHONY: validate
validate: ## Execute git-hooks
	@pre-commit run -a

# ====================================
# H U G O
# ====================================

##@ Hugo

.PHONY: submodule
submodule: ## initialize the docsy theme submodule
	git submodule update --init --recursive

.PHONY: submodule-reset
submodule-reset: ## reset submodules to tracked commit
	git submodule foreach --recursive git reset --hard

.PHONY: serve
serve: submodule ## Boot the development server.
	@echo -e "$(OK_COLOR)[$(APP)] Documentation$(NO_COLOR)"
	hugo server --buildFuture --baseUrl http://127.0.0.1

.PHONY: build
build: submodule ## Generate the static site into the /public folder
	npm install
	hugo --environment production --cleanDestinationDir

# ====================================
# C O N T A I N E R
# ====================================

##@ Container

.PHONY: container-build
container-build: submodule ## Build a container image for the preview of the website
	docker build -t $(CONTAINER_IMAGE) .

.PHONY: container-serve
container-serve: ## Boot the development server using container. Run `make container-image` before this.
	docker run -p 8080:80 $(CONTAINER_IMAGE)
