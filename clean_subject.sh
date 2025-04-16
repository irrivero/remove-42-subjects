#!/bin/bash
# Make sure we're at the root of a git repository
if [ ! -d .git ]; then
    echo "⚠️ You are not inside a git repository."
    exit 1
fi

# Find all files with "subject" in the name and .pdf extension
FILES=$(find . -type f -name "*subject*.pdf")
if [ -z "$FILES" ]; then
    echo "✅ No subject PDF files found."
    exit 0
fi

# Show found files
echo "📄 Found files:"
echo "$FILES"

# Remove all subject PDF files using git filter-repo
for FILE in $FILES; do
    git filter-repo --path "$FILE" --invert-paths --force
done

# Add patterns to .gitignore if they're not already there
if ! grep -q "\*subject\*.pdf" .gitignore 2>/dev/null; then
    echo "*subject*.pdf" >> .gitignore
    git add .gitignore
    git commit -m "add subject pattern to .gitignore"
fi

# Re-add remote if it was removed
REMOTE=$(git remote get-url origin 2>/dev/null)
if [ -z "$REMOTE" ]; then
    read -p "❓ No remote found. Enter the remote URL (e.g. git@github.com:user/repo.git): " URL
    git remote add origin "$URL"
else
    echo "🔗 Remote origin already configured: $REMOTE"
fi

# Force push
git push origin --force --all
git push origin --force --tags
echo "✅ Done. Repo is clean of subject files."