#! /bin/bash

set -e

. .env

LOCALHOST_WRITE_SIDE="http://localhost:44001"
LOCALHOST_READ_SIDE="http://localhost:44002"

post() {
  echo "curl -X POST /$2"
  curl --fail-with-body \
    -X POST \
    -H 'Content-type: application/json' \
    -H "Authorization: Bearer $1" \
    --url ${LOCALHOST_WRITE_SIDE}/$2 \
    -d "$3"
}

post $USER_A2_ID inbox '{
  "@context": ["https://www.w3.org/ns/activitystreams"],
  "type": "Follow",
  "actor": {
    "type": "member",
    "id": "'$LOCALHOST_READ_SIDE'/members/'$USER_A2_ID'"
  },
  "object": {
    "type": "member",
    "id": "'$USER_B2_ID'"
  }
}'

post $USER_A1_ID inbox '{
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

