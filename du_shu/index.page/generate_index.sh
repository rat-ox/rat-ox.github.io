#!/bin/bash

# Check if index.data file exists
if [ ! -f index.data ]; then
    echo "index.data file not found!"
    exit 1
fi

# Read the title and subtitle
title=$(sed -n '1p' index.data)
subtitle=$(sed -n '2p' index.data)

# Initialize counters and flags
item_counter=0
is_first_item=true
list_item_counter=1

# Start the HTML file
cat <<EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$title</title>
    <link rel="stylesheet" href="../index.page/style.css">
    <script src="../index.page/script.js" defer></script>
    <style>
    .hidden {
        display: none;
    }
    .content a {
        text-decoration: none;
        color: inherit;
        display: block;
        padding: 0px 0;
    }
    .content a:hover {
        text-decoration: none;
    }
    .content p {
        margin: 0;
        padding: 0;
    }
    a {
        text-decoration: none;
        color: #333;
    }
    a:hover {
        color: #fff;
        background-color: #33a;
        padding: 0px;
        border-radius: 0px;
    }
    </style>
</head>
<body>
    <h1>$title</h1>
    <p class="description">$subtitle</p>
    <ul>
EOF

# Read through the data file line by line, starting from the 3rd line
sed '1,2d' index.data | while read -r line; do
    if [[ $line == 📚* ]]; then
        if [ "$is_first_item" = false ]; then
            echo '        </div>' >> index.html
            echo '    </li>' >> index.html
        fi
        item_counter=$((item_counter + 1))
        item_num=$(printf "%03d" $item_counter)
        echo '    <li>' >> index.html
        echo '        <a href="#" class="toggle" data-target="item'$item_num'">'${line:2}'</a>' >> index.html
        echo '        <div class="content hidden" id="item'$item_num'">' >> index.html
        is_first_item=false
    else
        # Generate a unique sequence number for each list item
        list_item_num=$(printf "%03d" $list_item_counter)
        echo '            <a href="'$list_item_num'.html" target="_blank">' >> index.html
        echo "                <p>$line</p>" >> index.html
        echo '            </a>' >> index.html
        list_item_counter=$((list_item_counter + 1))
    fi
done

# Close the last item and the HTML file
if [ "$is_first_item" = false ]; then
    echo '        </div>' >> index.html
    echo '    </li>' >> index.html
fi

cat <<EOF >> index.html
    </ul>
</body>
</html>
EOF

echo "index.html has been generated successfully."
