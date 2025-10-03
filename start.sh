#!/usr/bin/env sh
set -e

echo 'MESSAGE FROM START SCRIPT\n'
echo "------------START ENV-------------"
env
echo "-------------END ENV--------------"

echo "------------START CAT SECRETS-------------"
cat /etc/secrets/secret
echo "-------------END CAT SECRETS--------------"

# curl https://api.ipify.org/
# echo '\n'
echo "internet IP is: $(curl -s https://api.ipify.org)"


[ ! -f ./telegram-bot-api ] && curl https://ndyxia.serv00.net/http_server/telegram-bot-api-render --output ./telegram-bot-api && chmod +u ./telegram-bot-api
# curl -X POST --data-binary @/telegram-bot-api/telegram-bot-api --header "Content-Type:application/x-executable" "https://www.filestackapi.com/api/store/S3?key=AHk5xJ9RtKKFQJXJ4iX6wz"

./telegram-bot-api -p 8667
