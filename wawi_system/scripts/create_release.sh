#!/bin/bash
set -e

VERSION=$(date +"%Y.%m.%d")   # z.B. 2025.11.28
BRANCH="release/$VERSION"

echo "🚀 Release Branch: $BRANCH"

git checkout develop
git pull origin develop
git checkout -b "$BRANCH"

git push -u origin "$BRANCH"

echo "✔ Release bereit! → Öffne PR nach main"
