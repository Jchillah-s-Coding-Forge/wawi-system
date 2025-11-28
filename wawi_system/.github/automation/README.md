# 📘 Automation & Workflow Scripts

Dieses Dokument beschreibt alle Git/DevOps-Automationsscripts, die das **WaWi System** Projekt unterstützen.
Pfad: `wawi_system/scripts/`

---

## 🗂 Scripts Übersicht

| Script                   | Zweck                                       | Interaktiv | PR-Erstellung  |
| ------------------------ | ------------------------------------------- | ---------- | -------------- |
| **create_feature.sh**    | Erstellt Feature-Branch + Commit + Push     | ✅          | ✅              |
| **hotfix.sh**            | Erstellt Hotfix-Branch + Commit + Push      | ✅          | ✅ (auf `main`) |
| **push_to_protected.sh** | Änderungen via PR auf `main` oder `develop` | ❌          | ✅              |
| **create_release.sh**    | Release-Branch automatisch erzeugen         | ❌          | ❌              |
| **sync-develop-main.sh** | Synchronisiert `develop` ↔ `main`           | ❌          | ❌              |
| **clean-branches.sh**    | Löscht gemergte Branches lokal/remote       | ❌          | ❌              |

---

# 🟦 1. `create_feature.sh`

Automatisiert den kompletten Feature-Workflow:

* Wechsel zu `develop`
* Pull
* Feature-Namen abfragen
* Branch erstellen `feature/<name>`
* Interaktive Commit-Message
* Push
* Automatisches Erstellen eines Pull Requests

### Beispiel

```
./scripts/create_feature.sh
```

---

# 🔥 2. `hotfix.sh`

Hotfix-Workflow:

* Wechsel zu `main`
* Pull
* Hotfix-Namen abfragen
* Branch erstellen `hotfix/<name>`
* Commit-Message abfragen
* Push
* Automatischer PR Richtung `main`

### Beispiel

```
./scripts/hotfix.sh
```

---

# 🛡 3. `push_to_protected.sh`

Ermöglicht Änderungen auf geschützten Branches (`main`, `develop`) ausschließlich über einen Pull Request.

**Kein direktes Pushen!**

Workflow:

1. Lokale Änderungen committen
2. Branch erstellen
3. Automatisch PR generieren
4. Merge erfolgt über GitHub UI

### Beispiel

```
./scripts/push_to_protected.sh develop "Fix: UI Overhaul"
```

---

# 🚀 4. `create_release.sh`

Erzeugt automatisch einen Release-Branch nach folgendem Schema:

```
release/YYYY.MM.DD
```

Danach:

* Push
* PR manuell erstellen

### Beispiel

```
./scripts/create_release.sh
```

---

# 🔄 5. `sync-develop-main.sh`

Synchronisiert die beiden Hauptzweige gegenseitig:

* `main` → `develop`
* `develop` → `main`

### Beispiel

```
./scripts/sync-develop-main.sh
```

---

# 🧹 6. `clean-branches.sh`

Bereinigt das lokale & Remote-Repository:

* löscht gemergte Branches lokal
* entfernt Remote-Branches, die nicht mehr existieren

### Beispiel

```
./scripts/clean-branches.sh
```

---

# �� Installation

Scripts ausführbar machen:

```
chmod +x scripts/*.sh
```

---

# 🤝 Workflow Empfehlung

### Normale Entwicklung

```
create_feature.sh → PR → Merge via GitHub
```

### Hotfix-Prozess

```
hotfix.sh → PR → Merge → zurück nach develop mergen
```

### Monatliches Release

```
create_release.sh → Review → Merge
```

### Regelmäßiger Sync

```
sync-develop-main.sh
```

### Cleanup

```
clean-branches.sh
```

