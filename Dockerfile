FROM python:latest

WORKDIR /app

RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir pipenv

ADD Pipfile Pipfile.lock ./
RUN pipenv install
#RUN pip install --no-cache-dir -r requirements.txt

ADD . /app
