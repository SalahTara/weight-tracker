# Run `make help` to see available targets.

# Variables
NPM := npm
SRC := $(shell find src public -type f) index.html vite.config.ts tsconfig*.json $(wildcard .env*)

# Load local secrets (like VERCEL_TOKEN) if the file exists, and pass them to commands.
-include .env.local
export VERCEL_TOKEN
export VERCEL_ORG_ID
export VERCEL_PROJECT_ID

# The first target is the default one, so a bare `make` runs `make build`.
.DEFAULT_GOAL := build

# These targets are commands, not files, so Make should always run them.
.PHONY: build install dev lint preview deploy clean help

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

## deploy: build and deploy to Vercel production (needs VERCEL_TOKEN)
deploy: node_modules
	@test -n "$$VERCEL_TOKEN" || { echo "VERCEL_TOKEN is not set. Add it to .env.local."; exit 1; }
	npx vercel pull --yes --environment=production --token="$$VERCEL_TOKEN"
	npx vercel build --prod --token="$$VERCEL_TOKEN"
	npx vercel deploy --prebuilt --prod --token="$$VERCEL_TOKEN"

## clean: remove build output and dependencies
clean:
	rm -rf dist node_modules

## help: list available targets
help:
	@grep -hE '^## ' $(MAKEFILE_LIST) | sed 's/^## /  /'
