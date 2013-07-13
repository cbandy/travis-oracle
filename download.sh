#!/bin/sh

export COOKIES='cookies.txt'
export USER_AGENT='Mozilla/5.0'

echo > "$COOKIES"
chmod 600 "$COOKIES"

phantomjs download.js |
curl --cookie "$COOKIES" --cookie-jar "$COOKIES" --data '@-' \
  --location --output "$ORACLE_FILE" --user-agent "$USER_AGENT" \
  'https://login.oracle.com/oam/server/sso/auth_cred_submit'

