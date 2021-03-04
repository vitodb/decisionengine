#!/bin/bash -xe
CMD=${1:- -m pytest}
LOGFILE=${2:- pytest.log}

id
echo "GITHUB_WORKSPACE: ${GITHUB_WORKSPACE}"
echo "RUNNER_WORKSPACE: ${RUNNER_WORKSPACE}"
sleep 2
pwd
sleep 2
ls -lh
sleep 2
ls -lh ..

python3 setup.py bdist_wheel
python3 -m pip install -r requirements/requirements-runtime.txt
python3 -m pip install -r requirements/requirements-develop.txt
# make sure the pipe doesn't eat failures
set -o pipefail
# run the test
python3 ${CMD} 2>&1 | tee ${LOGFILE}
