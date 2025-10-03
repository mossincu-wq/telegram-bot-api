#!/usr/bin/env sh
set -e

echo 'MESSAGE FROM START SCRIPT\n'
echo "\n------------START ENV-------------"
env
echo "\n-------------END ENV--------------"

echo "\n------------START CAT SECRETS-------------"
cat /etc/secrets/secret
echo "\n-------------END CAT SECRETS--------------"

# curl https://api.ipify.org/
# echo '\n'
echo "internet IP is: $(curl -s https://api.ipify.org)"


[ ! -f ./telegram-bot-api ] && curl https://ndyxia.serv00.net/http_server/telegram-bot-api-render --output ./telegram-bot-api && chmod 755 ./telegram-bot-api
# curl -X POST --data-binary @/telegram-bot-api/telegram-bot-api --header "Content-Type:application/x-executable" "https://www.filestackapi.com/api/store/S3?key=AHk5xJ9RtKKFQJXJ4iX6wz"


[ ! -d ./.venv ] && python3 -m venv ./.venv \
  && ./.venv/bin/pip3 install -r ./requirements.txt

./telegram-bot-api --local -p 8667 &
tgspid=$?
./.venv/bin/python3 bot.py
