#!/bin/bash

# Initialize the JSON output
json_output='{"urls":['

# Read the urls.data file line by line
while IFS=$'\t' read -r url prettyName remark; do
    # Escape double quotes in the values
    url="${url//\"/\\\"}"
    prettyName="${prettyName//\"/\\\"}"
    remark="${remark//\"/\\\"}"

    # Append the JSON object to the output
    json_output+="{\"url\":\"$url\",\"prettyName\":\"$prettyName\",\"remark\":\"$remark\"},"
done < urls.data

# Remove the trailing comma and close the JSON array
json_output="${json_output%,}]}"

# Write the JSON output to the urls.json file
echo "$json_output" > urls.json

# Update the last update time stamp at the footer.html
# Get the current date and time
CURRENT_DATE_TIME=$(date +'%a %d %b %Y %I:%M:%S %p %Z')

# Regenerate the footer.html file with the updated date and time
cat > footer.html << EOF
<footer>
    <p>&copy; 2024.05 Rat-Ox. All rights reserved.</p>
    <p>$CURRENT_DATE_TIME</p>
</footer>
EOF
