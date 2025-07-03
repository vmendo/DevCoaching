#!/bin/bash

# Define source and target directories
export DEMO_HOME="$(cd "$(dirname "$0")/../.." && pwd)"
SOURCE_DIR="$DEMO_HOME/aux/custom/base_release"
TARGET_DIR="$DEMO_HOME/my_projects/hr/dist/releases/next/changes/base-release/_custom"

# List of SQL files to append
FILES=("populate_tables_with_demo_data.sql")

# Loop through each file and append content
for file in "${FILES[@]}"; do
    SOURCE_FILE="$SOURCE_DIR/$file"
    TARGET_FILE="$TARGET_DIR/$file"

    # Check if both source and target files exist
    if [[ -f "$SOURCE_FILE" && -f "$TARGET_FILE" ]]; then
        echo "Appending $SOURCE_FILE to $TARGET_FILE..."
        cat "$SOURCE_FILE" >> "$TARGET_FILE"
        echo "Done."
    else
        echo "Skipping $file: Source or target file missing."
    fi
done

echo "All files processed."

