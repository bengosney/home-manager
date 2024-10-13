.PHONY: help update switch
.DEFAULT_GOAL:=help

help: ## Display this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

switch: ## Apply changes
	nix-shell --run "home-manager switch"

update: ## Update packages
	nix-shell --run "niv update"
