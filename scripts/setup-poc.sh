#! /bin/bash

set -ex

. .env

randomActorA() {
  shuf -z --random-source=/dev/random -n1 -e $USER_A1_ID $USER_A2_ID $USER_A3_ID
}

randomActorB() {
  shuf -z --random-source=/dev/random -n1 -e $USER_B1_ID $USER_B2_ID $USER_B3_ID
}

API="${1:-http://localhost:44001}"

post() {
  sleep 1
  curl --fail-with-body \
    -X POST \
    -H 'Content-type: application/json' \
    -H "Authorization: Bearer $1" \
    --url $2 \
    -d "$3"
}

post `randomActorA` $COMMUNITY_A/api/community '{
  "id": "slytherin",
  "name": "Slytherin House",
  "affiliation": "Hogwarts School of Witchcraft and Wizardry",
  "overview": [
    "Slytherin is one of the four Houses at Hogwarts School of Witchcraft and Wizardry, founded by Salazar Slytherin. In establishing the house, Salazar instructed the Sorting Hat to pick students who had a few particular characteristics he most valued. Those characteristics included cunning, resourcefulness, leadership, and ambition.",
    "The emblematic animal of the house is the snake and the house colours are green and silver."
  ],
  "theme": "emerald"
}'

post `randomActorB` $COMMUNITY_B/api/community '{
  "id": "gryffindor",
  "name": "Gryffindor House",
  "affiliation": "Hogwarts School of Witchcraft and Wizardry",
  "overview": [
    "Gryffindor is one of the four Houses of Hogwarts School of Witchcraft and Wizardry and was founded by Godric Gryffindor. Gryffindor instructed the Sorting Hat to choose students possessing characteristics he most valued, such as courage, chivalry, nerve and determination, to be sorted into his house.",
    "The emblematic animal is a lion, and its colours are scarlet and gold and its house point hourglass is filled with rubies. Sir Nicholas de Mimsy-Porpington, also known as Nearly Headless Nick, is the House ghost."
  ],
  "theme": "red"
}'

