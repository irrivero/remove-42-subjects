# 42 Git Subject Cleaner

## Description
This script automates the removal of 42 School "subject" PDF files from your Git repository, completely eliminating them from history. It's specifically designed for 42. We need to remove subject files that shouldn't be pushed to public repositories according to the school's guidelines. It handles both standard subject files ("en.subject.pdf") and variations like "subject (1).pdf".

## Features
- Detects and removes any PDF file with "subject" in its name (including 42's standard "en.subject.pdf" files)
- Completely cleans the Git history using `git-filter-repo`
- Automatically updates the `.gitignore` file to prevent future inclusions
- Reconfigures the remote repository if necessary
- Force pushes changes to the remote repository

## Requirements
- Git
- [git-filter-repo](https://github.com/newren/git-filter-repo)

## Installation
```bash
# Install git-filter-repo
pip install git-filter-repo
```

## Usage
1. Navigate to the root directory of your 42 project repository
2. Run the script:
```bash
./clean_subject.sh
```

## ⚠️ Warning
- This script performs a `git push --force`, which will overwrite the remote repository history
- All collaborators will need to clone the repository again after running this script
- Make a backup before running this script on important repositories

## Customization
You can modify the search pattern in the script to adapt it to your specific needs:
```bash
# To search for other patterns, modify this line:
FILES=$(find . -type f -name "*subject*.pdf")
```
