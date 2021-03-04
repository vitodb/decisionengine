#!/bin/bash -xe
CMD=${1:- -m pytest}
LOGFILE=${2:- pytest.log}

echo "GITHUB_WORKSPACE: ${GITHUB_WORKSPACE}"
pwd
ls -lh
ls -lh ..
ls -lh ../..

cd decisionengine
python3 setup.py bdist_wheel
python3 -m pip install -r requirements/requirements-runtime.txt
python3 -m pip install -r requirements/requirements-develop.txt
# make sure the pipe doesn't eat failures
set -o pipefail
# run the test
python3 ${CMD} 2>&1 | tee ${LOGFILE}
