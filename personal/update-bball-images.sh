#!/bin/bash
# Script to automatically update bball-images.json with all .jpg files in bball-figs directory

BBALL_FIGS_DIR="bball-figs"
JSON_FILE="bball-images.json"

# Check if directory exists
if [ ! -d "$BBALL_FIGS_DIR" ]; then
  echo "Error: $BBALL_FIGS_DIR directory not found"
  exit 1
fi

# Get all .jpg files and create JSON array
echo "Updating $JSON_FILE with images from $BBALL_FIGS_DIR..."
cd "$(dirname "$0")"

# Create JSON array of .jpg files
echo "[" > "$JSON_FILE"
ls -1 "$BBALL_FIGS_DIR"/*.jpg 2>/dev/null | sed 's|.*/||' | sed 's/^/  "/;s/$/",/' | sed '$ s/,$//' >> "$JSON_FILE"
echo "]" >> "$JSON_FILE"

# Count images
IMAGE_COUNT=$(ls -1 "$BBALL_FIGS_DIR"/*.jpg 2>/dev/null | wc -l)
echo "Found $IMAGE_COUNT image(s) and updated $JSON_FILE"

