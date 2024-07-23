#!/bin/bash

url=$1

status_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")

if [ "$status_code" -eq 200 ]; then
  echo "Application status: up"
elif [[ "$status_code" -ge 400 && "$status_code" -le 504 ]]; then
  echo "Application status: down"
else
  echo "Application status: unknown"
fi
