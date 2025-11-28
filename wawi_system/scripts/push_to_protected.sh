#!/bin/bash
set -e

PROTECTED_BRANCHES=("main" "develop")

# Aktuellen Branch ermitteln
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "🔍 Aktueller Branch: $CURRENT_BRANCH"

# Prüfen, ob Branch geschützt ist
IS_PROTECTED=false
for b in "${PROTECTED_BRANCHES[@]}"; do
    if [[ "$CURRENT_BRANCH" == "$b" ]]; then
        IS_PROTECTED=true
        break
    fi
done

# Wenn Branch geschützt → neuen Branch erstellen
if [[ "$IS_PROTECTED" == true ]]; then
    echo "⛔ $CURRENT_BRANCH ist geschützt. Erstelle neuen Arbeits-Branch…"

    TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
    NEW_BRANCH="auto/${CURRENT_BRANCH}-update-$TIMESTAMP"

    echo "📌 Neuer Branch: $NEW_BRANCH"

    git checkout -b "$NEW_BRANCH"
else
    echo "✔ $CURRENT_BRANCH ist nicht geschützt. Änderungen werden normal gepusht."
    NEW_BRANCH="$CURRENT_BRANCH"
fi

# Sicherstellen, dass Dateien gestaged sind
if [[ -z "$(git status --porcelain)" ]]; then
    echo "⚠️ Keine Änderungen zu committen."
else
    echo "📦 Committe Änderungen…"
    git add .
    git commit -m "Auto: Push changes via push_to_protected.sh"
fi

# Branch pushen
echo "⬆️  Pushe Branch $NEW_BRANCH …"
git push -u origin "$NEW_BRANCH"

# PR URL generieren
REPO_URL=$(git config --get remote.origin.url | sed -e 's/\.git$//')
[[ $REPO_URL =~ ^git@github\.com:(.*)/(.*)$ ]] && REPO_URL="https://github.com/${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"

PR_URL="$REPO_URL/compare/develop...$NEW_BRANCH?expand=1"

echo "✅ Fertig! Pull Request öffnen:"
echo "$PR_URL"
