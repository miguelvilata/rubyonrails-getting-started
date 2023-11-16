# Makefile for Ruby on Rails project with Docker

# Set the default target to show help
.DEFAULT_GOAL := help

# Define variables
DOCKER_COMPOSE := docker-compose
DOCKER_COMPOSE_FILE := docker-compose.yml

# Help target to display available targets
help:
	@echo "Available targets:"
	@echo "  make start          - Start the Ruby on Rails project using Docker"
	@echo "  make stop           - Stop the Ruby on Rails project Docker containers"
	@echo "  make restart        - Restart the Ruby on Rails project Docker containers"
	@echo "  make init           - Initialize the project (create Docker images)"
	@echo "  make test           - Run tests for the Ruby on Rails project"
	@echo "  make recreate       - Recreate containers"
	@echo "  make clean          - Stop the project and remove Docker containers"
	@echo "  make clean-all      - Clean and also remove Docker images and volumes"
	@echo "  make ruby-shell     - Ruby container shell"

# Start the Ruby on Rails project using Docker
start:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d --remove-orphans

# Stop the Ruby on Rails project Docker containers
stop:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down --remove-orphans

# Restart the Ruby on Rails project Docker containers
restart: stop start

# Initialize the project (create Docker images)
init:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) build

# Recreate containers
recreate:
	make stop
	docker-compose up --build

# Run tests for the Ruby on Rails project
test:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) run --rm app ./bin/rails test

# Stop the project and remove Docker containers
clean: stop
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) rm -f

# Clean and also remove Docker images and volumes
clean-all: clean
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v

# Shell
ruby-shell:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) run --rm app /bin/bash

.PHONY: help start stop restart init test clean clean-all ruby-shell

