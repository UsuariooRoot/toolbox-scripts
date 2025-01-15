# replace-content-files.sh

A Bash script to simplify the replacement of content in multiple files based on include and exclude patterns.

## Motivation
When working with icon packs, such as those downloaded from [XFCE Look](https://www.xfce-look.org), replacing the same SVG icon content across different file names and versions can be tedious. This script automates the process, avoiding the need for manual copy-pasting.

## Features
- Replace the content of multiple files with the content from a single origin file.
- Flexible pattern matching to include or exclude specific files.

## Usage
```bash
./replace-content-files.sh ORIGIN_FILE (-i PATTERN1 PATTERN2... | -e PATTERN1 PATTERN2...) [-i|-e PATTERN1 PATTERN2...]
```

### Parameters
- `ORIGIN_FILE`: The file whose content will be used for replacement.
- `-i`: Specifies patterns of files to include. You can provide multiple patterns.
- `-e`: Specifies patterns of files to exclude. You can provide multiple patterns.

### Examples
1. Replace content in all files containing "text" but exclude those containing "important":
   ```bash
   ./replace-content-files.sh <origin file> -i '*text*' -e '*important*'
   ```

2. Replace content in all Markdown files that do not contain "draft":
   ```bash
   ./replace-content-files.sh <origin file> -i '*.md' -e '*draft*'
   ```

## License
This script is provided under the MIT License. Feel free to modify and distribute it.
