#!/usr/bin/env bash

count=0
number=0
number_blank=1
squeeze=0
prev_line='SOF'

print_usage() {
  "$0" <<EOF
Usage: ${0##*/} [OPTION]... [FILE]...
       ${0##*/} -h
Concatenate FILE(s) to standard output.

With no FILE, or when FILE is -, read standard input.

OPTIONS
EOF
  get_flag_documentation
}

get_flag_documentation() {
  while read -r line; do
    if [[ "$line" = "###"* ]]; then
      echo "${line/\###/   }"
    fi
  done <"$0"
}

if [[ "$*" = *--help* ]]; then
  print_usage
  exit 0
fi

while getopts bnsh opt; do
  case "$opt" in
    ### -b	Number all non-blank output lines, starting at 1.
    ###   	Overrides -n.
    b)
      number=1
      number_blank=0
      ;;
    ### -n	Number all output lines, starting at 1.
    n)
      number=1
      ;;
    ### -h	Show this help message.
    h)
      print_usage
      exit 0
      ;;
    ### -s	Squeeze repeated empty output lines.
    s)
      squeeze=1
      ;;
    *)
      print_usage >&2
      exit 1
      ;;
  esac
done

shift $(( OPTIND - 1 ))

print_count() {
  if ((number)) && { ((number_blank)) || [[ -n "$1" ]]; }; then
    printf '%6d\t' $((++count))
  fi
}

echo_stdin() {
  while IFS= read -r line; do
    if [[ -n "$line" ]] || [[ -n "$prev_line" ]]; then
      print_count "$line"
      echo "$line"
    fi
    prev_line="$line"
  done
}

for file in "${@:--}"; do
  if [[ "$file" = "-" ]]; then
    echo_stdin
  elif [[ -r "$file" ]]; then
    echo_stdin <"$file"
  else
    echo "${0}: ${file}: Cannot read" >&2
  fi
done
