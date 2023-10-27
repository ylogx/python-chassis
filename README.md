Template Python
===============

Installation
------------

```bash
APP_NAME=my-new-app
git clone --recursive git@github.com:ylogx/python-chassis.git ${APP_NAME}

make init # Install dependencies and setup venv

# TODO: Ignore .git
grep -lR "python-chassis" . | xargs sed -i "s/python-chassis/${APP_NAME}/g"
```

Run
---

```bash
make lint test # Perform linting and test
make run
```
