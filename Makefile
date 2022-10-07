GIT_TAG=$$(git describe --always)

all: ci
ci: lint test

# Poetry Package Manager
check_poetry:
	@hash poetry || echo "ERROR: Consider using: make install_poetry_ci"
	@poetry --version && poetry check

install_poetry_ci:
	curl -sSL https://install.python-poetry.org | python3 - -y

init: init_poetry

init_poetry: check_poetry
	poetry lock
	poetry install
	poetry install --only dev

init_ci: install_poetry_ci init_poetry_ci

init_poetry_ci: check_poetry
	poetry install --no-root --no-ansi

update: update_poetry

update_poetry: check_poetry init_poetry
	poetry update

init_dev: check_poetry
	@hash pre-commit || poetry add --dev pre-commit
	# poetry run pre-commit install -t pre-commit -t pre-push
	pre-commit install -t pre-commit -t pre-push

ci: lint_ci test_ci
ci_original: lint test

lint:
	@hash black || poetry add --dev black
	@which black && black --version
	black .

lint_ci: check_poetry
	poetry run black .

test:
	@hash pytest || poetry add --dev pytest
	@which pytest && pytest --version
	pytest

test_ci: check_poetry
	poetry run pytest


run:
	poetry run python run.py --help
	poetry run python run.py perform

sh:
	poetry shell


# Docker Compose
up:
	docker-compose up -d --build

logs:
	docker-compose logs -f

down:
	docker-compose down

# Docker
build:
	docker build --pull -f Dockerfile -t python-chassis .

drun: build
	docker run -v $$(pwd):/app --rm -it python-chassis bash -c "poetry run python run.py bizness"

dsh: build
	docker run -v $$(pwd):/app --rm -it python-chassis poetry shell
