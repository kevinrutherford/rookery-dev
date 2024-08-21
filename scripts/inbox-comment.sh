#! /bin/bash

set -e

. .env

API="${1:-http://localhost:44001}"

post() {
  curl --fail-with-body \
    -X POST \
    -H 'Content-type: application/json' \
    -H "Authorization: Bearer randomActor" \
    --url ${API}/$1 \
    -d "$2"
}

post inbox '{
  "@context": [
    "https://www.w3.org/ns/activitystreams"
  ],
  "type": "Create",
  "actor": {
    "id": "https://mastodon.me.uk/api/members/'$USER_A1_ID'"
  },
  "published": "'`date -Iseconds`'",
  "object": {
    "type": "Note",
    "content": "Something something effective something"
  },
  "target": {
    "type": "discussion",
    "id": "203455fe-eb71-4cea-894f-a8954a261fd3"
  }
}'

