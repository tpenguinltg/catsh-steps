#!/usr/bin/env bash

echo_stdin() {
  while IFS= read -r line; do
    echo "$line"
  done
}

if [[ $# -eq 0 ]]; then
  echo_stdin
else
  for file in "$@"; do
    if [[ -r "$file" ]]; then
      echo_stdin <"$file"
    else
      echo "${0}: ${file}: Cannot read" >&2
    fi
  done
fi
