#! /bin/bash

set -e

. .env

randomActor() {
  shuf -z --random-source=/dev/random -n1 -e $USER_B1_ID $USER_B2_ID $USER_B3_ID
}

API="${1:-http://localhost:44001}"

post() {
  sleep 1
  echo "curl -X POST ${API}/$1"
  curl --fail-with-body \
    -X POST \
    -H 'Content-type: application/json' \
    -H "Authorization: Bearer `randomActor`" \
    --url ${API}/$1 \
    -d "$2"
}

patch() {
  sleep 2
  echo "curl -X PATCH ${API}/$1"
  curl --fail-with-body \
    -X PATCH \
    -H 'Content-type: application/json' \
    -H "Authorization: Bearer `randomActor`" \
    --url ${API}/$1 \
    -d "$2"
}

post community '{
  "id": "gryffindor",
  "name": "Gryffindor House",
  "affiliation": "Hogwarts School of Witchcraft and Wizardry",
  "overview": [
    "Gryffindor is one of the four Houses of Hogwarts School of Witchcraft and Wizardry and was founded by Godric Gryffindor. Gryffindor instructed the Sorting Hat to choose students possessing characteristics he most valued, such as courage, chivalry, nerve and determination, to be sorted into his house.",
    "The emblematic animal is a lion, and its colours are scarlet and gold and its house point hourglass is filled with rubies. Sir Nicholas de Mimsy-Porpington, also known as Nearly Headless Nick, is the House ghost."
  ],
  "theme": "sky"
}'

COLLECTION_1_ID="herbology"
COLLECTION_2_ID="creatures"
COLLECTION_3_ID="dark-arts"

post collections '{
  "id": "'$COLLECTION_1_ID'",
  "name": "Herbology",
  "description": "Required reading for Hogwarts herbology classes."
}'

post collections '{
  "id": "'$COLLECTION_2_ID'",
  "name": "Care of Magical Creatures",
  "description": "Required reading for the Care of Magical Creatures elective subject."
}'

post collections '{
  "id": "'$COLLECTION_3_ID'",
  "name": "Defence Against the Dark Arts",
  "description": "Required reading for students taking Defence Against the Dark Arts at Hogwarts."
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

post discussions '{
  "id": "'$ENTRY_1_ID'",
  "doi": "10.7717/peerj.9630",
  "collectionId": "'$COLLECTION_1_ID'"
}'

post discussions '{
  "id": "'$ENTRY_2_ID'",
  "doi": "10.1101/2021.10.28.466232",
  "collectionId": "'$COLLECTION_1_ID'"
}'

post discussions '{
  "id": "'$ENTRY_3_ID'",
  "doi": "10.1101/2023.12.08.570760",
  "collectionId": "'$COLLECTION_2_ID'"
}'

post discussions '{
  "id": "'$ENTRY_4_ID'",
  "doi": "10.1101/2022.05.17.492376",
  "collectionId": "'$COLLECTION_2_ID'"
}'

post discussions '{
  "id": "`uuidgen`",
  "doi": "10.1101/999999",
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

post discussions '{
  "id": "'$ENTRY_5_ID'",
  "doi": "10.1101/2024.06.06.597796",
  "collectionId": "'$COLLECTION_3_ID'"
}'

post comments '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_5_ID'",
  "content": "This paper has been reviewed by eLife"
}'

