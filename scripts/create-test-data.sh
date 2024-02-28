#! /bin/bash

set -e

COLLECTION_1_ID=`uuidgen`
COLLECTION_2_ID=`uuidgen`

curl --fail-with-body -X POST --url http://localhost:44001/collections -d '{
  "id": "'$COLLECTION_1_ID'",
  "handle": "chs",
  "name": "CHS",
  "description": "Papers under review by the CHS project"
}'

curl --fail-with-body -X POST --url http://localhost:44001/collections -d '{
  "id": "'$COLLECTION_2_ID'",
  "handle": "pru3",
  "name": "PRU3",
  "description": "Papers to be referenced by the PRU3 project"
}'

