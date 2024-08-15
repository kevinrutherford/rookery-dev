#! /bin/bash

set -e

. .env

create_collection
assert_collection_appears_in_followers_feed
start_discussion
assert_discussion_appears_in_followers_feed
add_comment
assert_comment_appears_in_followers_feed

