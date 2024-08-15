#! /bin/bash

set -ex

#- config - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

. .env

COLLECTION_1_ID="poisons-`mktemp -u XXXXXXXXXX`"

#- helpers - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

randomActor() {
  echo 'abc'
}

get() {
  curl --fail-with-body \
    -X GET \
    -H 'Accept: application/json' \
    -H "Authorization: Bearer $1" \
    --url $2
}

post() {
  curl --fail-with-body \
    -X POST \
    -H 'Content-type: application/json' \
    -H "Authorization: Bearer $1" \
    --url $2 \
    -d "$3"
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
  post `randomActor` ${COMMUNITY_A}/entries '{
  "id": "'$ENTRY_1_ID'",
  "doi": "10.21203/rs.3.rs-4595783/v1",
  "collectionId": "'$COLLECTION_1_ID'"
}'
}

assert_discussion_appears_in_followers_feed() {
  get `randomActor` ${COMMUNITY_B}/timelines/followed
}

add_comment() {
  post `randomActor` ${COMMUNITY_A}/comments '{
  "id": "'$(uuidgen)'",
  "entryId": "'$ENTRY_1_ID'",
  "content": "I love this!"
}'
}

assert_comment_appears_in_followers_feed() {
  get `randomActor` ${COMMUNITY_B}/timelines/followed
}


#- main - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_collection
assert_collection_appears_in_followers_feed
start_discussion
assert_discussion_appears_in_followers_feed
add_comment
assert_comment_appears_in_followers_feed

