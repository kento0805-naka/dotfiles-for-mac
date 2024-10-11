.PHONY: all
all: init link brew

.PHONY: init
init:
	@echo "\033[0;34mRun init.sh\033[0m"
	@.bin/init.sh
	@echo "\033[0;34mDone.\033[0m"

.PHONY: link
link:
	@echo "\033[0;34mRun link.sh\033[0m"
	@.bin/link.sh
	@echo "\033[0;34mDone.\033[0m"

.PHONY: brew
brew:
	@echo "\033[0;34mRun brew.sh\033[0m"
	@.bin/brew.sh
	@echo "\033[0;34mDone.\033[0m"
