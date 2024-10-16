#!/bin/bash

# Check if index.data exists
if [ ! -f index.data ]; then
    echo "index.data file not found!"
    exit 1
fi

# Read the first line from index.data as the page title
read -r page_title < index.data
# Read the second line from index.data as the detailed description
detailed_description=$(sed -n '2p' index.data)

# Start writing the HTML content to index.html
cat <<EOL > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$page_title</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <h1>$page_title</h1>
    <p class="description">$detailed_description</p>
    <ul>
EOL

# Read the rest of index.data and append to index.html
counter=1
tail -n +3 index.data | while IFS= read -r title
do
    if [ $((counter % 2)) -eq 0 ]; then
        row_class="even"
    else
        row_class="odd"
    fi
    printf '        <li class="%s"><a href="%03d.html" target="_blank"><span class="number">%03d</span> <span class="title">%s</span></a></li>\n' "$row_class" "$counter" "$counter" "$title" >> index.html
    counter=$((counter + 1))
done

# Close the HTML tags
cat <<EOL >> index.html
    </ul>
</body>
</html>
EOL

echo "index.html has been generated."
