---
name: todo-fixme-watcher
description: A tool that scans your project for TODO and FIXME comments and generates a grouped summary.
version: 0.1.0
license: Apache-2.0
---

# TODO and FIXME Watcher

## Purpose
This skill scans a project directory for comments starting with TODO or FIXME. it extracts the comment text, identifies the file and line number, and detects optional priority tags like `todo(high)`. It provides a structured summary grouped by file to help you track technical debt.

## Instructions
1. Run the script provided in `scripts/run.sh`.
2. Provide the directory path to scan as an argument (defaults to the current directory).
3. Optionally use flags to filter by priority or comment type.
4. Review the summary output to stdout.

## Inputs
- **Directory Path**: The path to the directory you want to scan (positional argument).
- **Exclude Pattern**: (Optional) A pattern to exclude directories like `node_modules` or `.git`.

## Outputs
- **Summary Report**: A grouped list of TODOs and FIXMEs printed to stdout.

## Constraints
- Scans text files only.
- Relies on `grep` and standard Unix tools.
