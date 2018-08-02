#!/usr/bin/env bash

print_usage() {
  cat <<EOF
Usage: ${0##*/} [OPTION]... [FILE]...
       ${0##*/} -h
Concatenate FILE(s) to standard output.

With no FILE, or when FILE is -, read standard input.

OPTIONS
    -h	Show this help message.
EOF
}

if [[ "$*" = *--help* ]]; then
  print_usage
  exit 0
fi

while getopts h opt; do
  case "$opt" in
    h)
      print_usage
      exit 0
      ;;
  esac
done

shift $(( OPTIND - 1 ))

echo_stdin() {
  while IFS= read -r line; do
    echo "$line"
  done
}

if [[ $# -eq 0 ]]; then
  echo_stdin
else
  for file in "$@"; do
    if [[ "$file" = "-" ]]; then
      echo_stdin
    elif [[ -r "$file" ]]; then
      echo_stdin <"$file"
    else
      echo "${0}: ${file}: Cannot read" >&2
    fi
  done
fi
