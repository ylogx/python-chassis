lint:
	pipenv run black .

run:
	pipenv run python run.py --help
	pipenv run python run.py perform

init: install
install:
	pipenv install

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
