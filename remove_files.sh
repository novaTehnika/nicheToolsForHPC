#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <file_patternStart> <numbers_to_remove> <file_patternEnd>"
    exit 1
fi

# Get the filename pattern and the comma-separated list of numbers from the command-line arguments
file_patternStart="$1"
numbers_to_remove="$2"
file_patternEnd="$3"

# Convert the comma-separated string to an array
IFS=',' read -r -a numbers_array <<< "$numbers_to_remove"

# Loop through the array and remove the corresponding files
for num in "${numbers_array[@]}"; do
    filename="${file_patternStart}${num}${file_patternEnd}"
    echo "Removing files matching pattern: $filename"
    rm -f $filename
done

