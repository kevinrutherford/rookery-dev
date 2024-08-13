#! /bin/bash

set -e

. .env

API="${1:-http://localhost:44001}"

post() {
  sleep 2
  curl --fail-with-body \
    -X POST \
    -H 'Content-type: application/json' \
    --url ${API}/$1 \
    -d "$2"
}

post inbox '{
  "@context": [
    "https://www.w3.org/ns/activitystreams"
  ],
  "type": "Create",
  "actor": {
    "type": "member",
    "id": "https://mastodon.me.uk/users/kevinrutherford",
    "username": "voldemort",
    "avatarUrl": "https://upload.wikimedia.org/wikipedia/en/a/a3/Lordvoldemort.jpg",
  },
  "published": "2024-08-11T16:22:53Z",
  "to": [
    "https://www.w3.org/ns/activitystreams#Public"
  ],
  "object": {
    "id": "https://mastodon.me.uk/users/kevinrutherford/statuses/112944308111548072",
    "type": "Note",
    "summary": "Something something effective something",
    "published": "2024-08-11T16:22:53Z",
    "url": "https://mastodon.me.uk/@kevinrutherford/112944308111548072",
    "attributedTo": "https://mastodon.me.uk/users/kevinrutherford",
    "to": [
      "https://www.w3.org/ns/activitystreams#Public"
    ],
    "sensitive": false,
    "conversation": "tag:mathstodon.xyz,2024-08-11:objectId=109587681:objectType=Conversation",
    "content": "Something something effective something",
    "attachment": [],
    "target": {
      "id": "https://mastodon.me.uk/users/kevinrutherford/statuses/112944308111548072/replies",
      "type": "Discussion",
    }
  }

}'

