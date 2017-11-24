#!/bin/bash

if [ "$1" != "development" -a "$1" != "test" -a "$1" != "production" ]
then
  echo "Usage: run-server.sh <environment>"
  exit 1
else
  echo "Starting server in $1 environment..."
  RAILS_ENV=$1 bundle exec rails server -b 0.0.0.0 $2
fi
