#!/bin/bash

if [ "$1" == "" ]
then
  bundle exec rake redmine:plugins:test
else
  bundle exec rake redmine:plugins:test:$1
fi
