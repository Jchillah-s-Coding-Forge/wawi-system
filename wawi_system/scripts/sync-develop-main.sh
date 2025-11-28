#!/bin/bash
set -e

echo "🔄 Sync develop → main"

git checkout main
git pull origin main
git merge develop --no-ff
git push origin main

echo "🔁 Sync main → develop"

git checkout develop
git pull origin develop
git merge main --no-ff
git push origin develop

echo "✔ Beide Branches synchron!"
