#!/bin/bash

# Check if input file is provided
if [ -z "$1" ]; then
    echo "Usage: $0 input_file.html"
    exit 1
fi

input_file="$1"

# Strip HTML tags and save as plain text
plain_text_file="${input_file%.*}.txt"
sed 's/<[^>]*>//g' "$input_file" > "$plain_text_file"

# Convert plain text from GB2312 to UTF-8
output_file="${plain_text_file%.*}.utf8.txt"
iconv -c -f gb2312 -t utf-8 "$plain_text_file"
rm -f "$plain_text_file"
