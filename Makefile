# Run `make help` to see available targets.

# Variables
NPM := npm
# SRC := $(shell find src public -type f) index.html vite.config.ts tsconfig*.json

# The first target is the default one, so a bare `make` runs `make build`.
.DEFAULT_GOAL := build

# These targets are commands, not files, so Make should always run them.
.PHONY: build install dev lint preview clean help

## install: install dependencies (only re-runs when package files change)
install: node_modules

node_modules: package.json package-lock.json
	$(NPM) install
	@touch node_modules

## build: type-check and build the app into dist/
build: dist

dist: node_modules
	$(NPM) run build
	@touch dist

## dev: start the Vite dev server
dev: node_modules
	$(NPM) run dev

## lint: run ESLint
lint: node_modules
	$(NPM) run lint

## preview: serve the production build locally
preview: dist
	$(NPM) run preview

## clean: remove build output and dependencies
clean:
	rm -rf dist node_modules

## help: list available targets
help:
	@grep -E '^## ' $(MAKEFILE_LIST) | sed 's/^## /  /'
