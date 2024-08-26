#! /bin/bash

set -e

. .env

API="${1:-http://localhost:44001}"

post() {
  echo "curl -X POST ${API}/$1"
  curl --fail-with-body \
    -X POST \
    -H 'Content-type: application/json' \
    -H "Authorization: Bearer $1" \
    --url ${API}/$2 \
    -d "$3"
}

post $USER_B2_ID inbox '{
  "@context": ["https://www.w3.org/ns/activitystreams"],
  "type": "Follow",
  "actor": {
    "type": "member",
    "id": "'$COMMUNITY_B'/api/members/'$USER_B2_ID'"
  },
  "object": {
    "type": "member",
    "id": "'$USER_A2_ID'"
  }
}'

post randomActor inbox '{
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

