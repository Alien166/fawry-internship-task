#!/bin/bash

# Usage function
usage() {
  echo "Usage: $0 [-n] [-v] search_string filename"
  echo "Options:"
  echo "  -n    Show line numbers"
  echo "  -v    Invert match (show lines that do not match)"
  echo "  --help    Show this help message"
  exit 1
}

if [ $# -eq 0 ]; then
  usage
fi

show_line_number=false
invert_match=false

while getopts ":nv" opt; do
  case $opt in
    n)
      show_line_number=true
      ;;
    v)
      invert_match=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      ;;
  esac
done

shift $((OPTIND -1))

if [[ "$1" == "--help" ]]; then
  usage
fi

if [ $# -lt 2 ]; then
  echo "Error: Missing search string or filename."
  usage
fi

search_string="$1"
file="$2"

if [ ! -f "$file" ]; then
  echo "Error: File '$file' not found!"
  exit 1
fi

line_number=0

while IFS= read -r line; do
  ((line_number++))
  
  echo "$line" | grep -i -q "$search_string"
  match=$?

  if $invert_match; then
    match=$((!match))
  fi

  if [ $match -eq 0 ]; then
    if $show_line_number; then
      echo "${line_number}:$line"
    else
      echo "$line"
    fi
  fi

done < "$file"
