#!/bin/bash
set -e

echo "🧹 Bereinige lokale Branches…"
git branch --merged | grep -v "main" | grep -v "develop" | xargs git branch -d || true

echo "🧨 Bereinige Remote-Branches…"
git fetch --prune

echo "✔ Cleanup abgeschlossen!"
