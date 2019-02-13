GOCMD=go
#VERSION=$(shell git describe --tags)
VERSION=HEAD
GOBUILD=$(GOCMD) build -ldflags="-s -w -X github.com/triggermesh/aktion/cmd.version=$(VERSION)"
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
BINARY_NAME=aktion
BINARY_OSX=$(BINARY_NAME)_osx

.PHONY: all test clean run

all: build test

build: 
	$(GOBUILD) -o $(BINARY_NAME) -v

test: 
	$(GOTEST) -v ./...

clean: 
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
	rm -f $(BINARY_OSX)

run:
	$(GOBUILD) -o $(BINARY_NAME) -v 
	./$(BINARY_NAME)

install:
	$(GOCMD) install -v 

build-osx:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 $(GOBUILD) -o $(BINARY_OSX) -v
