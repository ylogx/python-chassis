FROM python:latest

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

ENV PYTHONUNBUFFERED 1
ENV POETRY_HOME "/opt/poetry"
ENV POETRY_VIRTUALENVS_IN_PROJECT 1
ENV POETRY_NO_INTERACTION 1
ENV PATH="/.venv/bin:${POETRY_HOME}/bin:$PATH"

RUN curl -sSL https://install.python-poetry.org | python3 - -y \
    && chmod 755 ${POETRY_HOME}/bin/poetry
COPY poetry.lock pyproject.toml ./
# RUN poetry install --only main --no-root --no-ansi
RUN ${POETRY_HOME}/bin/poetry install --only main --no-root --no-ansi

WORKDIR /app

COPY . .
