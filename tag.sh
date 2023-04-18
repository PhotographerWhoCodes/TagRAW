#!/bin/bash

# Check if two arguments were provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 [filepath A] [filepath B]"
    exit 1
fi

# Extract the directory paths and check if they exist
dirA=$(dirname "$1")
dirB=$(dirname "$2")
if [ ! -d "$dirA" ]; then
    echo "Error: $dirA is not a valid directory"
    exit 1
fi
if [ ! -d "$dirB" ]; then
    echo "Error: $dirB is not a valid directory"
    exit 1
fi

echo "Dir A: $dirA"
echo "Dir B: $dirB"

# Find all yellow files in filepath A
# yellow_files=$(mdfind "kMDItemUserTags == 'Yellow'" -onlyin "$dirA" | xargs -I{} basename {} | sed 's/\.[^.]*$//')
# yellow_files=$(mdfind "kMDItemUserTags == 'Yellow'" -onlyin "$dirA" | xargs -I{} basename {} | sed 's/\.[^.]*$//')
# yellow_files=$(find "$dirA" -name "*.JPG"  )
# yellow_files=$(find "$dirA" -name "*.JPG" -execdir bash -c 'mdls -name kMDItemUserTags "$0" | grep -q "Yellow" && echo "$0"' {} \; | sed 's/\.[^.]*$//')
yellow_files=$(find "$dirA" -name "*.JPG" -execdir bash -c 'mdls -name kMDItemFSLabel "$0" | grep -q "5" && echo "$0"' {} \; | sed 's/\.[^.]*$//')

echo "Yellow files in directory A:"
echo "$yellow_files"

# Check if there are any yellow files
if [ -z "$yellow_files" ]; then
    echo "No yellow files found in $dirA"
    exit 0
fi

# Tag orange files in filepath B that have the same name (without extension) as any yellow file
find "$dirB" -type f -print0 | while read -d $'\0' file; do
    filename=$(basename "$file")
    name=$(echo "$filename" | cut -f 1 -d '.')
    if echo "$yellow_files" | grep -q "$name"; then
        osascript -e "tell application \"Finder\" to set label index of (POSIX file \"$file\" as alias) to 2"
        echo "Tagged $filename in $dirB"
    fi
done
