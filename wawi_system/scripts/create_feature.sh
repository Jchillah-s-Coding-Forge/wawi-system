#!/bin/bash

# ================================
# WaWi Git Workflow Script
# ================================

# Stop on errors
set -e

# ------------------------
# PART 1 — Settings
# ------------------------
REPO="Jchillah-s-Coding-Forge/wawi-system"
BASE_BRANCH="develop"

# ------------------------
# PART 2 — Helper: Check current folder
# ------------------------
if [ ! -d .git ]; then
  echo "❌ Fehler: Dieses Verzeichnis ist kein Git-Repository."
  exit 1
fi

echo "📁 OK — Git Repository erkannt."

# ------------------------
# PART 3 — Switch to develop
# ------------------------
echo "➡️ Wechsle zu develop ..."
git checkout $BASE_BRANCH
git pull origin $BASE_BRANCH

# ------------------------
# PART 4 — Feature Branch Name
# ------------------------
echo ""
read -p "📌 Feature Name eingeben (z.B. project-setup): " FEATURE_NAME

if [ -z "$FEATURE_NAME" ]; then
  echo "❌ Kein Feature-Name eingegeben."
  exit 1
fi

FEATURE_BRANCH="feature/$FEATURE_NAME"

# ------------------------
# PART 5 — Branch erstellen
# ------------------------
echo "➡️ Erstelle Branch: $FEATURE_BRANCH"
git checkout -b "$FEATURE_BRANCH"

# ------------------------
# PART 6 — Commit erstellen
# ------------------------
echo ""
read -p "📝 Commit-Message eingeben: " COMMIT_MSG

git add .
git commit -m "$COMMIT_MSG"

echo "⬆️ Push zu origin ..."
git push -u origin "$FEATURE_BRANCH"

# ------------------------
# PART 7 — Pull Request erstellen
# ------------------------
echo "🛠  Erstelle Pull Request ..."

gh pr create \
  --base "$BASE_BRANCH" \
  --head "$FEATURE_BRANCH" \
  --repo "$REPO" \
  --title "$COMMIT_MSG" \
  --body "Automatisch erstellt via Workflow Script."

echo ""
echo "🎉 PR erfolgreich erstellt!"
