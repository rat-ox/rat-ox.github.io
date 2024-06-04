#!/bin/bash

# Check if the input file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

# Define input file and derive output file name
INPUT_FILE="$1"
OUTPUT_FILE="${INPUT_FILE%.data}.html"

# Read the first line as title
TITLE=$(head -n 1 "$INPUT_FILE")

# Read the rest of the file as content
CONTENT=$(tail -n +2 "$INPUT_FILE")

# Generate HTML content
cat << EOF > $OUTPUT_FILE
<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$TITLE</title>
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <div class="container">
        <div class="column-option">
            <label for="columns">选择多栏阅读：</label>
            <select id="columns" onchange="changeColumns()">
                <option value="1">单栏</option>
                <option value="2">双栏</option>
                <option value="3" selected>三栏</option>
                <option value="4">四栏</option>
            </select>
        </div>
        <div class="content" id="content">
            <h1>$TITLE</h1>
            $(echo "$CONTENT" | sed 's/^/<p>/; s/$/<\/p>/')
        </div>
    </div>
    <script>
        function changeColumns() {
            var select = document.getElementById("columns");
            var content = document.getElementById("content");
            content.style.columnCount = select.value;
        }
    </script>
</body>
</html>
EOF

echo "HTML file generated as $OUTPUT_FILE"
