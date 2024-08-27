#! /bin/bash

set -e

. .env

post() {
  sleep 1
  echo "curl -X POST $2"
  curl --fail-with-body \
    -X POST \
    -H 'Content-type: application/json' \
    -H "Authorization: Bearer $1" \
    --url $2 \
    -d "$3"
}

#--- Slytherin - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

post $USER_A1_ID $COMMUNITY_A/api/community '{
  "id": "slytherin",
  "name": "Slytherin House",
  "affiliation": "Hogwarts School of Witchcraft and Wizardry",
  "overview": [
    "Slytherin is one of the four Houses at Hogwarts School of Witchcraft and Wizardry, founded by Salazar Slytherin. In establishing the house, Salazar instructed the Sorting Hat to pick students who had a few particular characteristics he most valued. Those characteristics included cunning, resourcefulness, leadership, and ambition.",
    "The emblematic animal of the house is the snake and the house colours are green and silver."
  ],
  "theme": "emerald"
}'

COLLECTION_A1_ID="herbology"

post $USER_A2_ID $COMMUNITY_A/api/collections '{
  "id": "'$COLLECTION_A1_ID'",
  "name": "Dastardly spells",
  "description": "Required reading for death eaters."
}'

DISCUSSION_A1_ID=`uuidgen`

post $USER_A3_ID $COMMUNITY_A/api/discussions '{
  "id": "'$DISCUSSION_A1_ID'",
  "doi": "10.7554/elife.88287.3",
  "collectionId": "'$COLLECTION_A1_ID'"
}'

#--- Gryffindor - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

post $USER_B1_ID $COMMUNITY_B/api/community '{
  "id": "gryffindor",
  "name": "Gryffindor House",
  "affiliation": "Hogwarts School of Witchcraft and Wizardry",
  "overview": [
    "Gryffindor is one of the four Houses of Hogwarts School of Witchcraft and Wizardry and was founded by Godric Gryffindor. Gryffindor instructed the Sorting Hat to choose students possessing characteristics he most valued, such as courage, chivalry, nerve and determination, to be sorted into his house.",
    "The emblematic animal is a lion, and its colours are scarlet and gold and its house point hourglass is filled with rubies. Sir Nicholas de Mimsy-Porpington, also known as Nearly Headless Nick, is the House ghost."
  ],
  "theme": "red"
}'

COLLECTION_B1_ID="herbology"

post $USER_B2_ID $COMMUNITY_B/api/collections '{
  "id": "'$COLLECTION_B1_ID'",
  "name": "Herbology",
  "description": "Required reading for Hogwarts herbology classes."
}'

DISCUSSION_B1_ID=`uuidgen`

post $USER_B3_ID $COMMUNITY_B/api/discussions '{
  "id": "'$DISCUSSION_B1_ID'",
  "doi": "10.1101/2021.10.28.466232",
  "collectionId": "'$COLLECTION_B1_ID'"
}'

