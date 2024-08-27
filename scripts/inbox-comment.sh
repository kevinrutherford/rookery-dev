#! /bin/bash

set -e

. .env

LOCALHOST_WRITE_SIDE="http://localhost:44001"
LOCALHOST_READ_SIDE="http://localhost:44002"

get() {
  curl -s --fail-with-body \
    -X GET \
    -H 'Accept: application/json' \
    -H "Authorization: Bearer anyone" \
    --url ${LOCALHOST_READ_SIDE}/$1
}

post() {
  echo "curl -X POST ${LOCALHOST_WRITE_SIDE}/$2"
  curl --fail-with-body \
    -X POST \
    -H 'Content-type: application/json' \
    -H "Authorization: Bearer $1" \
    --url ${LOCALHOST_WRITE_SIDE}/$2 \
    -d "$3"
}

#--- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

discussionId=`get discussions | jq -M '.data[0].id' | sed -e 's/"//g'`

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
    "id": "'$discussionId'"
  }
}'

