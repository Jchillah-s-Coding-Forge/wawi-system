#!/bin/bash

# ================================
# WaWi Hotfix Workflow Script
# ================================
set -e

REPO="Jchillah-s-Coding-Forge/wawi-system"
MAIN="main"
DEVELOP="develop"

# 1) Wechsel zu main
echo "➡️ Wechsle zu main…"
git checkout $MAIN
git pull origin $MAIN

# 2) Hotfix-Namen abfragen
echo ""
read -p "🔥 Hotfix Name eingeben (z.B. login-failure): " HOTFIX

if [ -z "$HOTFIX" ]; then
  echo "❌ Kein Name eingegeben."
  exit 1
fi

HOTFIX_BRANCH="hotfix/$HOTFIX"

# 3) Hotfix-Branch erstellen
echo "➡️ Erstelle Hotfix Branch: $HOTFIX_BRANCH"
git checkout -b "$HOTFIX_BRANCH"

# 4) Commit Message
echo ""
read -p "📝 Commit-Message für Hotfix: " COMMIT_MSG

git add .
git commit -m "$COMMIT_MSG"

# 5) Push
echo "⬆️ Push zu origin ..."
git push -u origin "$HOTFIX_BRANCH"

# 6) Pull Request erstellen → MAIN
echo "🛠 Erstelle Pull Request Richtung MAIN …"
gh pr create \
  --base "$MAIN" \
  --head "$HOTFIX_BRANCH" \
  --repo "$REPO" \
  --title "[HOTFIX] $COMMIT_MSG" \
  --body "Automatisch erstellt via Hotfix Workflow Script."

echo "🎉 Hotfix PR erfolgreich erstellt!"
echo ""
echo "⚠️ Nach dem Merge **nicht vergessen**, den Hotfix zurück nach develop zu mergen!"
