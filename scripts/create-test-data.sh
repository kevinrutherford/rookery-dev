#! /bin/bash

set -e

API="${1:-http://localhost:44001}"

COLLECTION_1_ID=`uuidgen`
COLLECTION_2_ID=`uuidgen`

curl --fail-with-body -X POST -H 'Content-type: application/json' --url ${API}/collections -d '{
  "id": "'$COLLECTION_1_ID'",
  "handle": "chs",
  "name": "CHS",
  "description": "Papers under review by the CHS project"
}'

curl --fail-with-body -X POST -H 'Content-type: application/json' --url ${API}/collections -d '{
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

curl --fail-with-body -X POST -H 'Content-type: application/json' --url ${API}/entries -d '{
  "id": "'$ENTRY_1_ID'",
  "doi": "10.1126/science.1172133",
  "collectionId": "'$COLLECTION_1_ID'"
}'

curl --fail-with-body -X POST -H 'Content-type: application/json' --url ${API}/entries -d '{
  "id": "'$ENTRY_2_ID'",
  "doi": "10.3399/BJGP.2023.0216",
  "collectionId": "'$COLLECTION_1_ID'"
}'

curl --fail-with-body -X POST -H 'Content-type: application/json' --url ${API}/entries -d '{
  "id": "'$ENTRY_3_ID'",
  "doi": "10.1111/padm.12268",
  "collectionId": "'$COLLECTION_2_ID'"
}'

curl --fail-with-body -X POST -H 'Content-type: application/json' --url ${API}/comments -d '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_1_ID'",
  "content": "I love this!"
}'

curl --fail-with-body -X POST -H 'Content-type: application/json' --url ${API}/comments -d '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_1_ID'",
  "content": "Personally, I think it is a little overrated."
}'

curl --fail-with-body -X POST -H 'Content-type: application/json' --url ${API}/comments -d '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_3_ID'",
  "content": "Not relevant to our needs."
}'

