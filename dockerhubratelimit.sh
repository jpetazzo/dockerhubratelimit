#!/usr/bin/env bash

set -e
set -o pipefail

URL=https://registry-1.docker.io/v2/ratelimitpreview/test/manifests/latest

get_token() {
  echo "Obtaining token from Docker Hub."
  TOKEN=$(curl -s "https://auth.docker.io/token?service=registry.docker.io&scope=repository:ratelimitpreview/test:pull" | jq -r .token)
  AUTH="Authorization: Bearer $TOKEN"
}

view_ratelimit() {
  echo ---
  curl -s --head -H "$AUTH" "$URL" | grep ratelimit
}

drain_ratelimit() {
  for i in $(seq 100); do
    echo ---
    curl -f -s -H "$AUTH" "$URL" -o /dev/null --dump-header - | grep ratelimit
  done
}

get_token

case "$1" in
drain_and_exit)
  drain_ratelimit
  ;;
drain_and_loop)
  while true; do
    drain_ratelimit
    sleep 60
  done
  ;;
view_and_exit)
  view_ratelimit
  ;;
view_and_loop)
  while true; do
    view_ratelimit
    sleep 60
  done
  ;;
*)
  echo "Please specify action: view_and_exit, view_and_loop, drain_and_exit, drain_and_loop."
  exit 1
  ;;
esac
