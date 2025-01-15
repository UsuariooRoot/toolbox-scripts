#!/bin/bash

# Function to show script usage
show_usage() {
    cat <<EOF
Usage: $0 ORIGIN_FILE (-i PATTERN1 PATTERN2... | -e PATTERN1 PATTERN2...) [-i|-e PATTERN1 PATTERN2...]
  ORIGIN_FILE: File to be used to replace the content
  -i: File patterns to include
  -e: File patterns to exclude

Example:
  $0 -i <origin file> -i *text* -e *important* *.md
EOF
    exit 1
}

# Check if there are enough arguments
if [ $# -lt 3 ]; then
    show_usage
fi

# check if the first argument is a file and it exists
if [ ! -f "$1" ]; then
    echo "Error: The origin file '$1' does not exist or is not a regular file"
    exit 1
fi

source_file="$1"
include_patterns=()
exclude_patterns=()
current_flag=""
shift

# Process the arguments
while [ $# -gt 0 ]; do
    case "$1" in
    -i | -e)
        current_flag="$1"
        shift
        ;;
    *)
        if [ -z "$current_flag" ]; then
            echo "Error: -i or -e expected before pattern"
            exit 1
        fi
        if [ "$current_flag" = "-i" ]; then
            include_patterns+=("$1")
        else
            exclude_patterns+=("$1")
        fi
        shift
        ;;
    esac
done

# Check if there is at least one inclusion pattern
if [ ${#include_patterns[@]} -eq 0 ]; then
    echo "Error: You must specify at least one include pattern with -i"
    exit 1
fi

# Construir el comando find con los patrones
find_cmd="find . -type f"

# Add inclusion patterns
include_expr=""
for pattern in "${include_patterns[@]}"; do
    if [ -z "$include_expr" ]; then
        include_expr="-name \"$pattern\""
    else
        include_expr="$include_expr -o -name \"$pattern\""
    fi
done

# Add exclusion patterns
exclude_expr=""
for pattern in "${exclude_patterns[@]}"; do
    exclude_expr="$exclude_expr ! -name \"$pattern\""
done

# Build and run command
eval "$find_cmd \( $include_expr \) $exclude_expr" | while read -r file; do
    if [ -f "$file" ]; then
        echo "Replacing content of: $file"
        cat "$source_file" >"$file"
    fi
done

echo "Process completed"
