FROM nixery.dev/shell/curl/jq
COPY dockerhubratelimit.sh /
ENTRYPOINT ["/dockerhubratelimit.sh"]
