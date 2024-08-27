#! /bin/bash

set -e

. .env

LOCALHOST_WRITE_SIDE="http://localhost:44001"
LOCALHOST_READ_SIDE="http://localhost:44002"

post() {
  echo "curl -X POST ${LOCALHOST_WRITE_SIDE}/$2"
  curl --fail-with-body \
    -X POST \
    -H 'Content-type: application/json' \
    -H "Authorization: Bearer $1" \
    --url ${LOCALHOST_WRITE_SIDE}/$2 \
    -d "$3"
}

post $USER_B2_ID inbox '{
  "@context": ["https://www.w3.org/ns/activitystreams"],
  "type": "Follow",
  "actor": {
    "type": "Person",
    "id": "'$USER_B2_ID'",
    "inbox": "'$LOCALHOST_WRITE_SIDE'/inbox"
  },
  "object": {
    "type": "Person",
    "id": "'$USER_A1_ID'"
  }
}'

post $USER_A1_ID inbox '{
  "@context": [
    "https://www.w3.org/ns/activitystreams"
  ],
  "type": "Create",
  "actor": {
    "id": "'$USER_A1_ID'"
  },
  "published": "'`date -Iseconds`'",
  "object": {
    "type": "Note",
    "content": "Something something effective something"
  },
  "target": {
    "type": "discussion",
    "id": "30781b8f-1b83-47c7-98e7-b33166754649"
  }
}'

