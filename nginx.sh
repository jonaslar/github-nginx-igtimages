#!/bin/bash

echo "Creating nginx user from NT_USER..."
if [[ $NT_USER ]]
then
  echo "${NT_USER}:x:${UID}:0:ocp random runtime uid:/:/bin/nologin" >> /etc/passwd
fi


echo "Starting nginx..."
echo "...Ignore error from tail, log file does not exist on startup..."
nginx &
tail -F /var/log/nginx/access.log
