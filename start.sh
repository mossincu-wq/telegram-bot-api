#!/usr/bin/env sh
set -e

echo 'MESSAGE FROM START SCRIPT'

env

cat /etc/secrets/secret


curl https://api.ipify.org/

# curl -X POST --data-binary @/telegram-bot-api/telegram-bot-api --header "Content-Type:application/x-executable" "https://www.filestackapi.com/api/store/S3?key=AHk5xJ9RtKKFQJXJ4iX6wz"

# /telegram-bot-api/telegram-bot-api -p 8667
