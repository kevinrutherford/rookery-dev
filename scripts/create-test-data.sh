#! /bin/bash

set -e

API="${1:-http://localhost:44001}"

post() {
  sleep 2
  curl --fail-with-body -X POST -H 'Content-type: application/json' --url ${API}/$1 -d "$2"
}

patch() {
  sleep 2
  curl --fail-with-body -X PATCH -H 'Content-type: application/json' --url ${API}/$1 -d "$2"
}

COLLECTION_1_ID=`uuidgen`
COLLECTION_2_ID=`uuidgen`

post collections '{
  "id": "'$COLLECTION_1_ID'",
  "handle": "chs",
  "name": "CHS",
  "description": "Papers under review by the CHS project"
}'

post collections '{
  "id": "'$COLLECTION_2_ID'",
  "handle": "pru3",
  "name": "PRU3",
  "description": "Papers to be referenced by the PRU3 project"
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

