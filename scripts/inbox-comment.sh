#! /bin/bash

set -e

. .env

API="${1:-http://localhost:44001}"

post() {
  echo "curl -X POST ${API}/$1"
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
    "id": "'$COMMUNITY_A'/api/members/'$USER_A1_ID'"
  },
  "published": "'`date -Iseconds`'",
  "object": {
    "type": "Note",
    "content": "Something something effective something"
  },
  "target": {
    "type": "discussion",
    "id": "'$COMMUNITY_A'/api/discussions/6e35fed8-0220-4da4-a61a-43cefc910263"
  }
}'

