#!/bin/bash

PID=`ps -ef | grep "rails server" | grep -v grep | tr -s " " | cut -d " " -f 2`

if [ "$PID" != "" ]
then
  kill $PID
  echo "Server stopped."
else
  echo "Server is not running."
fi
