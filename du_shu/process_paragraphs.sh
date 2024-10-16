#!/bin/bash

# Function to process each file
process_file() {
    local file=$1
    awk '
    NR == 1 {
        # Print the first line as is (title)
        print $0
        next
    }
    {
        if (NF == 0) {
            # Print the accumulated paragraph if there is any
            if (length(paragraph) > 0) {
                print paragraph
                paragraph = ""
            }
            # Print the empty line to keep paragraph break
            print ""
        } else if ($0 ~ /^ {4}/) {
            # Print the accumulated paragraph if there is any
            if (length(paragraph) > 0) {
                print paragraph
                paragraph = ""
            }
            # Remove leading spaces and start a new paragraph
            gsub(/^ {4}/, "")
            paragraph = $0
        } else {
            # Concatenate non-indented lines into the current paragraph
            paragraph = (length(paragraph) > 0 ? paragraph $0 : $0)
        }
    }
    END {
        # Print the last paragraph if there is any
        if (length(paragraph) > 0) {
            print paragraph
        }
    }
    ' "$file"
}

# Check if at least one file is provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <file1> [file2] ..."
    exit 1
fi

# Process each file
for file in "$@"; do
    if [ -f "$file" ]; then
        echo "Processing file: $file"
        process_file "$file" > "${file}.data"
        echo "Modified file saved as: ${file}.data"
        \rm -fv $file
    else
        echo "File not found: $file"
    fi
done
