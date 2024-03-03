#! /bin/bash

set -e

COLLECTION_1_ID=collection.`uuidgen`
COLLECTION_2_ID=collection.`uuidgen`

curl --fail-with-body -X POST -H 'Content-type: application/json' --url http://localhost:44001/collections -d '{
  "id": "'$COLLECTION_1_ID'",
  "handle": "chs",
  "name": "CHS",
  "description": "Papers under review by the CHS project"
}'

curl --fail-with-body -X POST -H 'Content-type: application/json' --url http://localhost:44001/collections -d '{
  "id": "'$COLLECTION_2_ID'",
  "handle": "pru3",
  "name": "PRU3",
  "description": "Papers to be referenced by the PRU3 project"
}'

ENTRY_1_ID=entry.`uuidgen`
ENTRY_2_ID=entry.`uuidgen`
ENTRY_3_ID=entry.`uuidgen`
ENTRY_4_ID=entry.`uuidgen`
ENTRY_5_ID=entry.`uuidgen`

curl --fail-with-body -X POST -H 'Content-type: application/json' --url http://localhost:44001/entries -d '{
  "id": "'$ENTRY_1_ID'",
  "doi": "10.1126/science.1172133",
  "collectionId": "'$COLLECTION_1_ID'"
}'

curl --fail-with-body -X POST -H 'Content-type: application/json' --url http://localhost:44001/entries -d '{
  "id": "'$ENTRY_2_ID'",
  "doi": "10.3399/BJGP.2023.0216",
  "collectionId": "'$COLLECTION_1_ID'"
}'

curl --fail-with-body -X POST -H 'Content-type: application/json' --url http://localhost:44001/entries -d '{
  "id": "'$ENTRY_3_ID'",
  "doi": "10.1111/padm.12268",
  "collectionId": "'$COLLECTION_2_ID'"
}'

curl --fail-with-body -X POST -H 'Content-type: application/json' --url http://localhost:44001/comments -d '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_1_ID'",
  "content": "I love this!"
}'

curl --fail-with-body -X POST -H 'Content-type: application/json' --url http://localhost:44001/comments -d '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_1_ID'",
  "content": "Personally, I think it is a little overrated."
}'

curl --fail-with-body -X POST -H 'Content-type: application/json' --url http://localhost:44001/comments -d '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_3_ID'",
  "content": "Not relevant to our needs."
}'

