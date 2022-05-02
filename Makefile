.DEFAULT_GOAL := all

BUMP_PART ?= minor
export GOOS ?= darwin
export CGO_ENABLED ?= 1
export GO111MODULE ?= on

.PHONY: setup
setup:
	go mod tidy

all: build

.PHONY: build
build: setup bin/foo

bin/foo: cmd/foo/main.go
	CGO_ENABLED=0 go build -o $@ $<

.PHONY: install
install: build
	go install ./cmd/...

.PHONY: clean
clean: clean-build

.PHONY: clean-build
clean-build: ## remove build artifacts
	rm -f bin/foo
