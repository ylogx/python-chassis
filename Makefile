GIT_TAG=$$(git describe --always)

all: ci

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

ci: lint test
ci_dir: lint_dir test_dir

lint_dir:
	@hash black || poetry add --dev black
	@which black && black --version
	black .

lint: lint_ci
lint_ci: check_poetry
	poetry run black .

test_dir:
	@hash pytest || poetry add --dev pytest
	@which pytest && pytest --version
	pytest

test: test_ci
test_ci: check_poetry
	poetry run pytest


run:
	#poetry run python run.py --help
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
