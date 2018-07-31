#!/usr/bin/env bash

file="$1"

echo_stdin() {
  while IFS= read -r line; do
    echo "$line"
  done
}

if [[ -r "$file" ]]; then
  echo_stdin <"$file"
else
  echo_stdin
fi
