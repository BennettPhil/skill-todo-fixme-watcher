#!/usr/bin/env bash

# TODO and FIXME Watcher
# Scans files for technical debt comments and summarizes them.

set -euo pipefail

usage() {
  echo "Usage: $0 [DIRECTORY]"
  echo "Scans DIRECTORY for TODO and FIXME comments."
  echo "Default DIRECTORY is the current directory."
  exit 1
}

if [[ "${1:-}" == "--help" ]]; then
  usage
fi

TARGET_DIR="${1:-.}"

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "Error: Directory '$TARGET_DIR' does not exist."
  exit 1
fi

echo "Scanning $TARGET_DIR for TODO and FIXME..."
echo "=========================================="

# Use grep to find comments. -r (recursive), -n (line number), -E (regex)
# We exclude common non-source directories
grep -rEn "TODO|FIXME" "$TARGET_DIR" \
  --exclude-dir={.git,node_modules,dist,build,.soup} \
  | awk -F: '
    {
      file = $1
      line = $2
      # Extract everything after the first two colons
      comment = substr($0, index($0, $3))
      
      # Try to find priority in TODO(high) or FIXME(urgent)
      priority = "normal"
      if (match(comment, /(TODO|FIXME)\(([^)]+)\)/, arr)) {
        priority = arr[2]
      }
      
      # Store in array grouped by file
      files[file] = files[file] "\n  [Line " line "] [" priority "] " comment
    }
    END {
      for (f in files) {
        print "\nFile: " f
        print files[f]
      }
    }
  '

echo -e "\n=========================================="
echo "Scan complete."
