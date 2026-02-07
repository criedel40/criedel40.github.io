#!/bin/bash
# Script to copy bball predictions file from FORECASTSv5 to website directory

FORECASTS_DIR="/home/criedel/NEW-AI-BBALL/SCORE/FORECASTSv6"
WEBSITE_DIR="/home/criedel/NEW-AI-BBALL/criedel40.github.io/personal"
DATE_STR=$(date +%Y%m%d)
PREDICTIONS_FILE="bball_predictions:${DATE_STR}.json"

# Check if source directory exists
if [ ! -d "$FORECASTS_DIR" ]; then
  echo "Error: $FORECASTS_DIR directory not found"
  exit 1
fi

# Check if source file exists
if [ ! -f "$FORECASTS_DIR/$PREDICTIONS_FILE" ]; then
  echo "Error: $PREDICTIONS_FILE not found in $FORECASTS_DIR"
  exit 1
fi

# Copy file to website directory
echo "Copying $PREDICTIONS_FILE from $FORECASTS_DIR to $WEBSITE_DIR..."
cp "$FORECASTS_DIR/$PREDICTIONS_FILE" "$WEBSITE_DIR/$PREDICTIONS_FILE"

if [ $? -eq 0 ]; then
  echo "Successfully copied $PREDICTIONS_FILE to website directory"
else
  echo "Error: Failed to copy file"
  exit 1
fi

