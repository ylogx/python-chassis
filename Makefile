all: lint test

lint_ci: lint
lint:
	pipenv run black .

test_ci: test
test:
	pipenv run pytest

run:
	pipenv run python run.py --help
	pipenv run python run.py perform

init: install
install:
	pipenv install

init_ci: install_pipenv dev-install
install_pipenv:
	pip install -U pip
	pip install pipenv

dev-install:
	pipenv install --dev

sh:
	pipenv shell

build:
	docker build --pull -f Dockerfile -t template-python-pipenv .

drun: build
	docker run -v $$(pwd):/app --rm -it template-python-pipenv bash -c "pipenv run python run.py bizness"

dsh: build
	docker run -v $$(pwd):/app --rm -it cards pipenv shell
