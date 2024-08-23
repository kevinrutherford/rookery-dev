#! /bin/bash

set -e

#- config - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

. .env

COLLECTION_1_ID="poisons-`mktemp -u XXXXXXXXXX`"
DISCUSSION_1_ID=`uuidgen`

#- helpers - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

randomActor() {
  echo $USER_A2_ID
}

get() {
  echo "curl -X GET $1 $2"
  curl --fail-with-body \
    -X GET \
    -H 'Accept: application/json' \
    -H "Authorization: Bearer $1" \
    --url $2
  echo
}

post() {
  echo "curl -X POST $1 $2"
  curl --fail-with-body \
    -X POST \
    -H 'Content-type: application/json' \
    -H "Authorization: Bearer $1" \
    --url $2 \
    -d "$3"
  echo
}

create_collection() {
  post `randomActor` ${COMMUNITY_A}/api/collections '{
  "id": "'$COLLECTION_1_ID'",
  "name": "Poisons",
  "description": "Dastardly ways to kill Potter!"
}'
}

assert_collection_appears_in_followers_feed() {
  get `randomActor` ${COMMUNITY_B}/api/timelines/followed
}

start_discussion() {
  post `randomActor` ${COMMUNITY_A}/api/discussions '{
  "id": "'$DISCUSSION_1_ID'",
  "doi": "10.7717/peerj.9630",
  "collectionId": "'$COLLECTION_1_ID'"
}'
}

assert_discussion_appears_in_followers_feed() {
  get `randomActor` ${COMMUNITY_B}/api/timelines/followed
}

add_comment() {
  post `randomActor` ${COMMUNITY_A}/api/comments '{
  "id": "'$(uuidgen)'",
  "discussionId": "'$DISCUSSION_1_ID'",
  "content": "I love this!"
}'
}

assert_comment_appears_in_followers_feed() {
  get `randomActor` ${COMMUNITY_B}/api/timelines/followed
}


#- main - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_collection
assert_collection_appears_in_followers_feed
start_discussion
assert_discussion_appears_in_followers_feed
add_comment
assert_comment_appears_in_followers_feed

