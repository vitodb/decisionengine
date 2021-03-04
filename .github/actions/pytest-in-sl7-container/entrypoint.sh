#!/bin/bash -x
## cannot use -e as we lose the log that way
CMD=${1:- -m pytest}
LOGFILE=${2:- pytest.log}
cd decisionengine
python3 setup.py bdist_wheel
python3 -m pip install -r requirements/requirements-runtime.txt
python3 -m pip install -r requirements/requirements-develop.txt
# make sure the pipe doesn't eat failures
set -o pipefail
# run the test
python3 ${CMD} 2>&1 | tee ${LOGFILE}
