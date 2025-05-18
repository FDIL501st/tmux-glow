#!/bin/bash

markdown_file=""

# Function to set markdown_file
set_markdown_file() {
    # Look for *.md files in the current directory (no subdirectories)
    md_files=(*.md)

    # Only set markdown_file if at least one markdown file is found
    if [ ${#md_files[@]} -gt 0 ]; then
        markdown_file="${md_files[0]}"
    fi
}

set_markdown_file

# Print the selected markdown file (for debugging purposes)
echo "Markdown file: $markdown_file"
