#! /bin/bash

set -e

. .env

API="${1:-http://localhost:44001}"

post() {
  sleep 2
  curl --fail-with-body \
    -X POST \
    -H 'Content-type: application/json' \
    -H "Authorization: Bearer ${DEVELOPMENT_BEARER_TOKEN}" \
    --url ${API}/$1 \
    -d "$2"
}

patch() {
  sleep 2
  curl --fail-with-body \
    -X PATCH \
    -H 'Content-type: application/json' \
    -H "Authorization: Bearer ${DEVELOPMENT_BEARER_TOKEN}" \
    --url ${API}/$1 \
    -d "$2"
}

post community '{
  "id": "local-community",
  "name": "Health organisation, policy and economics (HOPE)",
  "affiliation": "Centre for Primary Care and Health Services Research, Manchester University",
  "overview": [
    "This interdisciplinary theme focuses upon research which investigates the supply, organisation, management and financing of health and social care services.",
    "Our expertise encompasses rigorous econometric analysis and a wide range of qualitative social scientific methods, including particular experience in the use of ethnographic approaches to understand organisational processes."
  ]
}'

COLLECTION_1_ID="chs"
COLLECTION_2_ID="pru3"
COLLECTION_3_ID="hidden"

post collections '{
  "id": "'$COLLECTION_1_ID'",
  "name": "CHS",
  "description": "Papers under review by the CHS project"
}'

post collections '{
  "id": "'$COLLECTION_2_ID'",
  "name": "PRU3",
  "description": "Papers to be referenced by the PRU3 project"
}'

post collections '{
  "id": "'$COLLECTION_3_ID'",
  "name": "Our private collection",
  "description": "This collection is only visible to authenticated members of this community"
}'

patch collections/$COLLECTION_3_ID '{
  "data": {
    "type": "collection",
    "id": "'$COLLECTION_3_ID'",
    "attributes": {
      "isPrivate": true
    }
  }
}'

ENTRY_1_ID=`uuidgen`
ENTRY_2_ID=`uuidgen`
ENTRY_3_ID=`uuidgen`
ENTRY_4_ID=`uuidgen`
ENTRY_5_ID=`uuidgen`

post entries '{
  "id": "'$ENTRY_1_ID'",
  "doi": "10.1126/science.1172133",
  "collectionId": "'$COLLECTION_1_ID'"
}'

post entries '{
  "id": "'$ENTRY_2_ID'",
  "doi": "10.3399/BJGP.2023.0216",
  "collectionId": "'$COLLECTION_1_ID'"
}'

post entries '{
  "id": "'$ENTRY_3_ID'",
  "doi": "10.1111/padm.12268",
  "collectionId": "'$COLLECTION_2_ID'"
}'

post entries '{
  "id": "'$ENTRY_4_ID'",
  "doi": "10.5555/666777",
  "collectionId": "'$COLLECTION_2_ID'"
}'

post comments '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_1_ID'",
  "content": "I love this!"
}'

post comments '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_1_ID'",
  "content": "Here is a very long comment, written entirely to test text justification in the browser page for the entry. If you are going to use a passage of Lorem Ipsum, you need to be sure there is nothing embarrassing hidden in the middle of text."
}'

post comments '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_3_ID'",
  "content": "Not relevant to our needs."
}'

post entries '{
  "id": "'$ENTRY_5_ID'",
  "doi": "10.7554/elife.95393.1",
  "collectionId": "'$COLLECTION_3_ID'"
}'

post comments '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_5_ID'",
  "content": "This paper has been reviewed by eLife"
}'

