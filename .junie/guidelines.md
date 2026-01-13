# Tammo — guidelines.md

## 1) Intent (Produktabsicht)

Tammo ist ein **Haustier-Management-System**, das Halter:innen hilft, **Gesundheit, Routinen und Unterlagen** ihrer Tiere zuverlässig zu erfassen und schnell wiederzufinden — **offline-first**, mit **minimaler Reibung** im Alltag.

### Primary Outcomes
- **Schnelles, strukturiertes Logging** (z. B. Durchfall/Erbrechen, Verhalten, Appetit)
- **Plan-basierte Routine** (Fütterung/Medikation) mit klarer Erledigt-Logik
- **Dokumente griffbereit** (Befunde, Impfpass, Rechnungen)
- **Verlauf & Export** (Tierarzt-ready, ohne „Raten“)

### Product Principles
1. **Offline-first**: Kernfunktionen müssen ohne Login und ohne Internet funktionieren.
2. **Low-friction by default**: 1–2 Taps für Kernaktionen („gegeben“, „Symptom erfassen“).
3. **Structure beats free text**: Templates + optionale Notizen statt unstrukturierter Einträge.
4. **Trust & Safety**: Datensicherheit, klare Grenzen (keine Diagnosen), transparente Datenhaltung.
5. **Scalable foundation**: Datenmodell immer mit `pet_id` (multi-pet-fähig), UI startet mit Single-Pet.

---

## 2) What Tammo is NOT (Non-Goals / Guardrails)

Tammo ist **nicht**:
- eine Tierarzt-App für **Diagnosen**, Therapieempfehlungen oder medizinische Entscheidungen
- ein „Symptom-Checker“ oder Ersatz für professionelle Beratung
- ein soziales Netzwerk, Chat oder Community-Feed
- ein Marketplace für Produkte/Dienstleistungen
- ein Fitness-Tracker-Clone (Aktivität nur, wenn klarer Health-/Routine-Nutzen)
- ein Kollaborationstool mit **Live-Sync** oder Echtzeit-Mehrgeräte-Konsistenz (vorerst)
- eine App, die ohne Zustimmung Daten an Dritte teilt oder Nutzer:innen zu Accounts zwingt

Out of Scope (initial / MVP):
- Live-Sync, Konfliktauflösung, Multi-Device Echtzeit
- Tierarzt-Accounts, Kommentare, gemeinsame Aktenführung
- Automatische Diagnosen, KI-„Behandlungsvorschläge“
- OCR/automatisches Parsing von Befunden (später möglich, nicht MVP)

---

## 3) Scope & Feature Boundaries (MVP)

### Foundation (Blocker)
- Single-Pet Profil (minimal: Name + Tierart) als Root Entity
- Lokale Persistenz
- Globaler Kontext: alles hängt an `pet_id`

### Core (MVP)
- Symptom/Event Logging + Timeline
- Fütterungs- & Medikamentenpläne + Check-ins + Reminder
- Dokumentenablage + Tags + schnelle Suche (ohne OCR)
- Export „Tierarztbericht“ (PDF)

### Monetarisierung (separat, aber vorbereitet)
- Optionaler Login + Cloud Backup (Supabase) — App bleibt ohne Login vollständig nutzbar

---

## 4) Tech Stack & Architektur (Flutter)

### Flutter Version & Tooling
- Flutter stable (aktueller stable Channel)
- Dart >= 3.x
- Lints: `very_good_analysis` oder `flutter_lints` + projekt-spezifische Ergänzungen
- Format: `dart format` (kein Diskussionsthema)

### Architectural Defaults
- **Layered architecture** (Clean-ish, pragmatisch):
    - `presentation/` (Widgets, Screens, UI State)
    - `application/` (Use Cases, Orchestrierung)
    - `domain/` (Entities, Value Objects, Interfaces)
    - `data/` (Repositories, DataSources, DTOs, Mappers)
- **Dependency Injection**: z. B. `riverpod` (empfohlen) oder `get_it` (ok). Entscheide 1, mische nicht.
- **State Management**: `riverpod` (empfohlen) oder `bloc`. Entscheide 1, bleib konsistent.

### Local Data (Offline-first)
- Lokale DB: `drift` (empfohlen) oder `isar`/`hive` (je nach Team-Familiarität).
- Regel: UI darf niemals direkt DB-Queries machen → nur über Repositories/Use Cases.

### Supabase (für Backup / später)
- Supabase Auth (E-Mail/Passwort)
- Supabase Storage / DB für Backup-Objekte
- Backup ist **optional**; Guest-Mode bleibt vollständig nutzbar.
- Keine Live-Sync-Annahme im Datenmodell (nur Backup/Restore).

---

## 5) Coding Guidelines (Dart/Flutter)

### General
- Schreibe Code so, dass ein:e neue:r Entwickler:in ihn ohne Kontext versteht.
- Prefer **small, composable widgets** over mega build methods.
- Keep side effects (IO, navigation, analytics) **out of pure UI** as much as reasonable.
- Every feature must be testable but don't write tests.
- Dont write tests and dont run flutter test.

### Naming
- Dateien/Ordner: `snake_case`
- Klassen: `PascalCase`
- Methoden/Variablen: `camelCase`
- Providers/Blocs: Name endet auf `Provider` / `Bloc` / `Controller` (konsistent)

### Null Safety & Types
- Keine `dynamic` in Business-Code.
- `late` nur wenn wirklich notwendig und begründet.
- Prefer `sealed`/`freezed` für UI States & Result-Typen.

### Error Handling
- Keine stillen Fehler: Jede Exception wird entweder:
    - in UI als klare Fehlermeldung gezeigt, oder
    - im Application Layer behandelt und geloggt.
- Prefer Result Types (`Either`, `Result`) statt throw-catch Ketten im UI.

### Data Modeling
- Domain Entities sind **immutable**.
- UI Models (DTOs) getrennt von Domain Entities.
- IDs als Strings/UUIDs (oder int, aber einheitlich). Nie „mal so, mal so“.
- Jede Tabelle/Entity muss `createdAt`, `updatedAt` unterstützen (mindestens lokal).

### UI Guidelines (Friction minimieren)
- Kernaktionen immer 1 Tap erreichbar:
    - „Symptom erfassen“
    - „Medikation gegeben“
    - „Fütterung erledigt“
- “Today”-Screen als primärer Einstieg.
- Formulare: Pflichtfelder minimal; „später ergänzen“ ist Standard.
- Accessibility: genügend Kontrast, Touch Targets >= 44px, semantische Labels.

### Performance
- Keine unnötigen rebuilds (const, selectors, `Consumer` scoped).
- Listen: `ListView.builder`, `SliverList`, Pagination wenn nötig.
- Bilder/Dokumente: Caching, Thumbnails, keine riesigen Memory Loads.

