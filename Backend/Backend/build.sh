#!/usr/bin/env bash
pip install -r requirements.txt

# exit on error
set -o errexit


python manage.py migrate --run-syncdb
python manage.py collectstatic
