#!/bin/bash

folder_to_monitor=""

while true; do
    file=$(inotifywait -r -e create -e moved_to --format "%w%f" "$folder_to_monitor")
    echo "File uploaded: $file"

    # Check if the file ends with ".avif"
    if [[ "$file" == *.avif ]]; then
        # Making timestamp for the file so there are no issues with filenames
        timestamp=$(date +%s)
        unique_id="${timestamp}${RANDOM}"
        echo "Converting $file to PNG"
        output_file="${file%.avif} [${timestamp}].png"
        ffmpeg -i "$file" "$output_file"
        echo "Conversion complete. Output file: $output_file"

        # Delete the original file
        rm "$file"
        echo "Original file deleted: $file"
    fi
done
