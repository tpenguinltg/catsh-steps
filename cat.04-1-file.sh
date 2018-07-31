#!/usr/bin/env bash

file="$1"

if [[ -r "$file" ]]; then
  while IFS= read -r line; do
    echo "$line"
  done <"$file"
else
  while IFS= read -r line; do
    echo "$line"
  done
fi
