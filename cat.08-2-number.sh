#!/usr/bin/env bash

count=0
number=0

print_usage() {
  cat <<EOF
Usage: ${0##*/} [OPTION]... [FILE]...
       ${0##*/} -h
Concatenate FILE(s) to standard output.

With no FILE, or when FILE is -, read standard input.

OPTIONS
EOF
  sed -n '/^[[:space:]]*###/s//   /p' "$0"
}

if [[ "$*" = *--help* ]]; then
  print_usage
  exit 0
fi

while getopts nh opt; do
  case "$opt" in
    ### -n	Number all output lines, starting at 1.
    n)
      number=1
      ;;
    ### -h	Show this help message.
    h)
      print_usage
      exit 0
      ;;
    *)
      print_usage >&2
      exit 1
      ;;
  esac
done

shift $(( OPTIND - 1 ))

echo_stdin() {
  while IFS= read -r line; do
    ((number)) && printf '%6d\t' $((++count))
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
