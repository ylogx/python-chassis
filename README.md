Python Template
===============

Installation
------------

```bash
APP_NAME=my-new-app
git clone --recursive git@github.com:ylogx/python-chassis.git ${APP_NAME}

grep -lR --exclude-dir=".git" "python-chassis" . | xargs sed -i "s/python-chassis/${APP_NAME}/g"
grep -lR --exclude-dir=".git" "Python Template" . | xargs sed -i "s/Python Template/${APP_NAME}/g"

make init # Install dependencies and setup venv
```

Run
---

```bash
make lint test # Perform linting and test
make run
```
