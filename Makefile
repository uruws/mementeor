.PHONY: default
default:
	@$(MAKE) build

.PHONY: build
build:
	@./docker/build.sh
