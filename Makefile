# Color definitions
RED    := $(shell tput setaf 1)
GREEN  := $(shell tput setaf 2)
YELLOW := $(shell tput setaf 3)
BLUE   := $(shell tput setaf 4)
RESET  := $(shell tput sgr0)
BOLD   := $(shell tput bold)

# OS Detection
UNAME := $(shell uname -s)

# Logging functions
define log_info
    @printf "$(BLUE)[*]$(RESET) %s\n" "$(1)"
endef

define log_success
    @printf "$(GREEN)[+]$(RESET) %s\n" "$(1)"
endef

define log_warning
    @printf "$(YELLOW)[!]$(RESET) %s\n" "$(1)"
endef

define log_error
    @printf "$(RED)[-]$(RESET) %s\n" "$(1)"
endef

##@ General

# The help target prints out all targets with their descriptions organized
# beneath their categories. The categories are represented by '##@' and the
# target descriptions by '##'. The awk command is responsible for reading the
# entire set of makefiles included in this invocation, looking for lines of the
# file as xyz: ## something, and then pretty-format the target and help.
.PHONY: help
help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\n$(BOLD)Usage:$(RESET)\n  make $(BLUE)<target>$(RESET)\n"} \
		/^[a-zA-Z_0-9-]+:.*?##/ { printf "  $(BLUE)%-15s$(RESET) %s\n", $$1, $$2 } \
		/^##@/ { printf "\n$(BOLD)%s$(RESET)\n", substr($$0, 5) }' $(MAKEFILE_LIST)

##@ Setup

.PHONY: all
all: init link brew tools ## Execute complete setup process
	$(call log_success,"Complete setup finished successfully!")

.PHONY: init
init: ## Set initial preferences
	$(call log_info,"Initializing system preferences...")
ifeq ($(UNAME), Darwin)
	@macos/scripts/init.sh && $(call log_success,"macOS initialization complete") || $(call log_error,"macOS initialization failed")
else ifeq ($(UNAME), Linux)
	@linux/scripts/init.sh && $(call log_success,"Linux initialization complete") || $(call log_error,"Linux initialization failed")
else
	$(call log_error,"Unsupported operating system: $(UNAME)")
	@exit 1
endif

.PHONY: link
link: ## Link dotfiles
	$(call log_info,"Creating symbolic links for dotfiles...")
ifeq ($(UNAME), Darwin)
	@macos/scripts/link.sh && $(call log_success,"Dotfiles linked successfully") || $(call log_error,"Failed to link dotfiles")
else ifeq ($(UNAME), Linux)
	@linux/scripts/link.sh && $(call log_success,"Dotfiles linked successfully") || $(call log_error,"Failed to link dotfiles")
else
	$(call log_error,"Unsupported operating system: $(UNAME)")
	@exit 1
endif

.PHONY: brew
brew: ## Install macOS package manager (Homebrew)
	$(call log_info,"Setting up package manager...")
ifeq ($(UNAME), Darwin)
	@macos/scripts/brew.sh && $(call log_success,"Homebrew installed successfully") || $(call log_error,"Homebrew installation failed")
else ifeq ($(UNAME), Linux)
	$(call log_warning,"Homebrew installation skipped - not required for Linux")
else
	$(call log_error,"Unsupported operating system: $(UNAME)")
	@exit 1
endif

.PHONY: tools
tools: ## Install development tools
	$(call log_info,"Installing development tools...")
ifeq ($(UNAME), Darwin)
	@macos/scripts/tools.sh && $(call log_success,"Tools installed successfully") || $(call log_error,"Tool installation failed")
else ifeq ($(UNAME), Linux)
	@linux/scripts/tools.sh && $(call log_success,"Tools installed successfully") || $(call log_error,"Tool installation failed")
else
	$(call log_error,"Unsupported operating system: $(UNAME)")
	@exit 1
endif
