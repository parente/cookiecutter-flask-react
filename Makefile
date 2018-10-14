# Application module name
APP_NAME:=example_app
# Docker image name and tag
IMAGE:=hub.docker.io/parente/$(APP_NAME)
TAG?=latest
# Shell that make should use
SHELL:=bash

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

jsdev-shell: ## Make a shell in a JavaScript dev docker container
	docker run --rm -it $(IMAGE):jsdev sh

pydev-shell: ## Make a shell in a Python dev docker container
	docker run --rm -it $(IMAGE):pydev sh

prod-shell: ## Make a shell in the latest production docker container
	docker run --rm -it $(IMAGE):$(TAG) sh

clean: ## Make a clean source tree
	-find . -name '*.pyc' -exec rm -fv {} \;
	rm -rf $(APP_NAME)/__pycache__ __pycache__
	rm -rf *.egg-info

pydev-image: ## Make a Python docker image with dev/test depdendencies
	docker build --rm --target pydev -t $(IMAGE):pydev .

jsdev-image: ## Make a JavaScript docker image with dev/test depdendencies
	docker build --rm --target jsdev -t $(IMAGE):jsdev .

prod-image: ## Make a docker image with minimal Python deps and minified JavaScript
	docker build --rm --target production -t $(IMAGE):$(TAG) .

flask: ## Make a dev flask server with source mounted from host
	docker run -it --rm \
		-e FLASK_APP=$(APP_NAME) \
		-e FLASK_DEBUG=1 \
		-e SECRET_KEY=dev-key \
		-v `pwd`:/usr/src/app \
		-p 5000:5000 \
		$(IMAGE):pydev \
		flask run -h 0.0.0.0

parcel: ## Make a dev parcel builder watching source on the host
	docker run -it --rm \
		-p 5001:5001 \
		-v `pwd`/$(APP_NAME)/static:/usr/src/app/$(APP_NAME)/static \
		$(IMAGE):jsdev \
		npm run watch -- --hmr-port 5001

stack: prod-image ## Make a local deployment using docker compose and swarm
	@-docker swarm init
	docker stack deploy \
		--prune \
		-c docker-compose.yml \
		$(APP_NAME)

unstack: ## Make a local docker compose deployment shutdown
	docker stack rm $(APP_NAME)

JSTEST_CONTAINER:=docker run -it --rm \
	-v `pwd`/$(APP_NAME)/static:/usr/src/app/$(APP_NAME)/static:ro \
	-v `pwd`/setupTests.js:/usr/src/app/setupTests.js:ro \
	-v `pwd`/.babelrc:/usr/src/app/.babelrc:ro \
	$(IMAGE):jsdev
jstest: jsdev-image # Make a jest test run in docker
	$(JSTEST_CONTAINER) npm run test -- --coverage

jstest-update: jsdev-image # Make an update of jest test snapshots in the source tree
	$(JSTEST_CONTAINER) npm run test -- -u

jstest-watch: jsdev-image # Make jest watch for JavaScript changes and run automatically in docker
	$(JSTEST_CONTAINER) npm run test -- --watchAll

PYTEST_CONTAINER:=docker run -it --rm -v `pwd`:/usr/src/app $(IMAGE):pydev
pytest: pydev-image ## Make a pytest run in docker
	$(PYTEST_CONTAINER) python run_tests.py -vxrs tests/

pytest-debug: pydev-image ## Make a pytest run with pdb enabled in docker
	$(PYTEST_CONTAINER) python run_tests.py -vxrs --pdb tests/
