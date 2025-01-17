##@ General

# The help target prints out all targets with their descriptions organized
# beneath their categories. The categories are represented by '##@' and the
# target descriptions by '##'. The awk commands is responsible for reading the
# entire set of makefiles included in this invocation, looking for lines of the
# file as xyz: ## something, and then pretty-format the target and help. Then,
# if there's a line with ##@ something, that gets pretty-printed as a category.
# More info on the usage of ANSI control characters for terminal formatting:
# https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters
# More info on the awk command:
# http://linuxcommand.org/lc3_adv_awk.php

.PHONY: help
help: ## display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Setup

.PHONY: all
all: init link brew tools ## do everything.

.PHONY: init
init: ## set initial preference.
	#echo "Execute init.sh"
	ifeq ($(UNAME), Darwin)
		macos/.bin/init.sh
	else
	ifeq ($(UNAME), Linux)
		linux/.bin/init.sh
	else
		@echo "This OS is unsupported."
	endif
	endif

.PHONY: link
link: ## link dotfiles.
	#echo "Execute link.sh"
	ifeq ($(UNAME), Darwin)
		macos/.bin/link.sh
	else
	ifeq ($(UNAME), Linux)
		linux/.bin/link.sh
	else
		@echo "This OS is unsupported."
	endif
	endif

.PHONY: brew
brew: ## install macOS package manager (homebrew).
	#echo "Execute link.sh"
	ifeq ($(UNAME), Darwin)
		macos/.bin/link.sh
	else
	ifeq ($(UNAME), Linux)
		@echo "Not required for this OS."
	else
		@echo "This OS is unsupported."
	endif
	endif

.PHONY: tools
tools: ## install tools for use in personal environment.
	#echo "Execute tools.sh"
	ifeq ($(UNAME), Darwin)
		macos/.bin/tools.sh
	else
	ifeq ($(UNAME), Linux)
		linux/.bin/tools.sh
	else
		@echo "This OS is unsupported."
	endif
	endif
