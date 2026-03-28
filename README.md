# 🎯 Prof AYA la Queen - Islamic Learning App

**Version 2026 | Flutter Application | iOS • Android • Web**

---

## 📋 Table des Matières

1. [Vue d'ensemble](#vue-densemble)
2. [Installation](#installation)
3. [Architecture](#architecture)
4. [Fichiers & Structure](#fichiers--structure)
5. [Guide Démarrage Rapide](#guide-démarrage-rapide)
6. [Modules](#modules)
7. [Données & APIs](#données--apis)
8. [Support](#support)

---

## 🌟 Vue d'ensemble

**Prof AYA la Queen** est une application pédagogique complète pour :

- 📖 Lire et étudier le **Coran** (114 Sourates)
- 📚 Apprendre l'**Arabe** (Alphabet, Vocabulaire, Grammaire)
- 🧠 Converser avec un **Tuteur IA** (Miss AYA)
- 🤝 Étudier les **Sciences Islamiques** (Hadith, Sunnah)

**Plateforme** : iOS + Android + Web (PWA)  
**Framework** : Flutter 3.x  
**Coût** : 100% Gratuit

---

## ⚡ Installation

### Prérequis

```bash
✅ Flutter SDK 3.0+
✅ Dart 3.0+
✅ Android Studio / Xcode (pour iOS)
✅ Git
```

### Étapes d'Installation

#### 1️⃣ Cloner/Créer le Projet

```bash
# Créer nouveau projet Flutter
flutter create flutter_app
cd flutter_app

# Ou cloner le repo (si disponible)
git clone https://github.com/yourrepo/aya-claude.git
cd aya-claude
```

#### 2️⃣ Copier les Fichiers

Copier les fichiers `.dart` fournis vers leur emplacement respectif :

```
lib/
├── main.dart                          # ✅ lib_main.dart
├── core/
│   ├── theme/
│   │   └── app_theme.dart            # ✅ core_theme_app_theme.dart
│   ├── constants/
│   │   └── app_strings.dart          # ✅ core_constants_app_strings.dart
│   ├── db/
│   │   └── database_service.dart     # ✅ core_db_database_service.dart
│   └── services/
│       ├── ai_service.dart           # ✅ core_services_ai_service.dart
│       └── logger_service.dart       # ✅ core_services_logger_service.dart
├── config/
│   ├── router.dart                   # ✅ config_router.dart
│   └── dependency_injection.dart     # ✅ config_dependency_injection.dart
└── features/
    ├── splash/
    │   └── presentation/screens/splash_screen.dart        # ✅
    ├── dashboard/
    │   └── presentation/screens/dashboard_screen.dart     # ✅
    ├── quran/
    │   └── presentation/screens/
    │       ├── quran_list_screen.dart                     # ✅
    │       └── surah_detail_screen.dart                   # ✅
    ├── arabic_learning/
    │   └── presentation/screens/learning_screen.dart      # ✅
    ├── ai_tutor/
    │   └── presentation/screens/ai_tutor_screen.dart      # ✅
    ├── hadith/
    │   └── presentation/screens/hadith_list_screen.dart   # ✅
    └── settings/
        └── presentation/screens/settings_screen.dart      # ✅
```

#### 3️⃣ Installer les Dépendances

```bash
# Remplacer le contenu de pubspec.yaml avec le fichier fourni
# Puis exécuter:
flutter pub get
```

#### 4️⃣ Télécharger les Assets

Créer dossiers et télécharger données :

```bash
# Créer structure assets
mkdir -p assets/{quran,hadith,vocabulary,images,models,fonts}

# Télécharger Coran JSON
# Source: https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/quran-uthmani.json
# → assets/quran/quran-uthmani.json

# Télécharger Hadith JSON
# Source: https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/eng-abudawud.json
# → assets/hadith/hadith-abudawud.json

# Télécharger Modèle IA (TinyLLaMA - 200-400 MB)
# Source: https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF
# → assets/models/tinyllama-1.1b-q4.gguf
```

#### 5️⃣ Lancer l'App

```bash
# Développement
flutter run

# Release (iOS)
flutter build ios --release

# Release (Android)
flutter build apk --release
flutter build appbundle --release

# Web
flutter build web --release
```

---

## 🏗️ Architecture

### Clean Architecture Pattern

```
Domain (Logique Métier)
   ↓
Data (Base de Données, APIs)
   ↓
Presentation (UI, Screens, Widgets)
```

### State Management

**Riverpod** pour la gestion d'état réactive.

Exemples de patterns :

```dart
// Data Provider
final databaseProvider = FutureProvider<Database>((ref) async {
  return await DatabaseService.instance.database;
});

// Business Logic Provider
final quranRepositoryProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return QuranRepositoryImpl(localDataSource: QuranLocalDataSource(db));
});

// UI Provider (StateNotifier)
final quranListProvider = StateNotifierProvider<
  QuranListNotifier,
  AsyncValue<List<SurahEntity>>
>((ref) {
  final useCase = ref.watch(getAllSurahsUseCaseProvider);
  return QuranListNotifier(useCase);
});
```

### Database Schema

**SQLite Local-First**

Tables principales :
- `quran_surahs` - Sourates
- `quran_verses` - Versets
- `hadith_collections` - Collections de Hadith
- `hadiths` - Hadiths
- `vocabulary_sets` - Ensembles vocabulaire
- `alphabet_letters` - Lettres Arabe
- `user_progress` - Progression utilisateur
- `bookmarks` - Favoris
- `user_quizzes` - Historique quiz

---

## 📂 Fichiers & Structure

### Fichiers Fournis

| Fichier | Emplacement | Description |
|---------|-------------|-------------|
| `lib_main.dart` | `lib/main.dart` | Point d'entrée |
| `pubspec.yaml` | `/` | Dépendances |
| `core_theme_app_theme.dart` | `lib/core/theme/` | Thème Material 3 |
| `core_constants_app_strings.dart` | `lib/core/constants/` | Textes constants |
| `core_db_database_service.dart` | `lib/core/db/` | Service SQLite |
| `core_services_ai_service.dart` | `lib/core/services/` | Service IA |
| `core_services_logger_service.dart` | `lib/core/services/` | Logger |
| `config_router.dart` | `lib/config/` | Routing |
| `config_dependency_injection.dart` | `lib/config/` | DI Setup |
| `features_splash_splash_screen.dart` | `lib/features/splash/` | Splash |
| `features_dashboard_dashboard_screen.dart` | `lib/features/dashboard/` | Dashboard |
| `features_quran_quran_list_screen.dart` | `lib/features/quran/` | Liste Coran |
| `features_quran_surah_detail_screen.dart` | `lib/features/quran/` | Détail Sourate |
| `features_arabic_learning_screen.dart` | `lib/features/arabic_learning/` | Arabe |
| `features_ai_tutor_screen.dart` | `lib/features/ai_tutor/` | IA Chat |
| `features_hadith_and_settings.dart` | `lib/features/{hadith,settings}/` | Hadith + Settings |

---

## 🚀 Guide Démarrage Rapide

### 1. Créer le Projet

```bash
flutter create --org=com.ayaclaude flutter_app
cd flutter_app
```

### 2. Copier Fichiers

Télécharger tous les fichiers `.dart` et les placer aux emplacements indiqués.

### 3. Remplacer pubspec.yaml

Copier le `pubspec.yaml` fourni.

### 4. Récupérer Dépendances

```bash
flutter pub get
```

### 5. Créer Assets

```bash
mkdir -p assets/{quran,hadith,vocabulary,images,models,fonts}
```

### 6. Lancer

```bash
flutter run
```

**Résultat** : App démarre avec Dashboard + 4 modules actifs

---

## 📱 Modules

### 1. 🕌 Module Coran

**Écran** : `/quran`

```
QuranListScreen
├── Liste 114 Sourates
└── → SurahDetailScreen
    ├── 7 versets de Al-Fatiha
    ├── Traduction Français
    ├── Translittération
    └── Audio (placeholder)
```

**Données** : `assets/quran/quran-uthmani.json`

---

### 2. 📚 Module Arabe

**Écran** : `/learn`

3 tabs :

```
Alphabet Tab
├── 28 lettres avec exemples
└── Modal détails par lettre

Vocabulaire Tab
├── 6 catégories thématiques
└── Listes mots (à implémenter)

Grammaire Tab
├── 4 règles de base
└── Explications + exemples
```

---

### 3. 🧠 Module IA

**Écran** : `/tutor`

```
AiTutorScreen
├── Chat avec Miss AYA
├── Responses générées (template)
├── Menu "Générer Quiz"
└── Historique messages
```

**Service** : `AIService` (Simulé - Intégrer TinyLLaMA)

---

### 4. 🤝 Module Hadith

**Écran** : `/hadith`

```
HadithListScreen
├── 6 Collections (Bukhari, Muslim, Abu Dawud, etc.)
└── Placeholder pour détails (à développer)
```

---

## 📊 Données & APIs

### Sources

| Ressource | API | Format | Gratuit |
|-----------|-----|--------|---------|
| Coran | Quran API (fawazahmed0) | JSON | ✅ |
| Hadith | Hadith API (fawazahmed0) | JSON | ✅ |
| IA | TinyLLaMA | GGUF (GGML) | ✅ |

### Utilisation

```dart
// Charger Coran au premier démarrage
await quranLocalDataSource.loadQuranFromAssets();

// Requête Coran
final surahs = await db.query('quran_surahs');
final verses = await db.query('quran_verses', 
  where: 'surah_id = ?', 
  whereArgs: [1]
);

// IA Response
final response = await aiService.generateResponse(prompt);

// Quiz Adaptatif
final quiz = await aiService.generateQuiz(topic: 'Arabe', count: 5);
```

---

## ⚙️ Configuration

### Firebase (Optionnel pour Sync Cloud)

1. Créer projet Firebase
2. Télécharger `google-services.json` (Android)
3. Télécharger `GoogleService-Info.plist` (iOS)
4. Placer dans `android/app/` et `ios/Runner/`

### Ollama Backend (Optionnel pour IA Améliorée)

```dockerfile
# backend/Dockerfile
FROM ollama/ollama:latest
RUN ollama serve & sleep 5 && ollama pull tinyllama
EXPOSE 11434
```

Deploy sur Google Cloud Run (gratuit).

---

## 🧪 Tests

```bash
# Unit Tests
flutter test

# Widget Tests
flutter test test/features/

# Coverage
flutter test --coverage
lcov --list coverage/lcov.info
```

---

## 📦 Build & Deployment

### iOS

```bash
flutter build ios --release
# Archive dans Xcode → TestFlight/App Store
```

### Android

```bash
# APK (debug/release)
flutter build apk --release

# App Bundle (Play Store)
flutter build appbundle --release
```

### Web

```bash
flutter build web --release
# Déployer sur Firebase Hosting
firebase deploy --only hosting
```

---

## 🐛 Troubleshooting

### Erreur : "database.db not found"

```dart
// Solution : Initialize database au premier lancement
await DatabaseService.instance.database;
```

### Erreur : "Riverpod dependency error"

```dart
// Solution : Ensure all providers sont dans dependency_injection.dart
final databaseProvider = FutureProvider(...);
```

### Erreur : "Assets not found"

```bash
# Vérifier pubspec.yaml
flutter:
  assets:
    - assets/quran/
    - assets/hadith/
    # etc...

# Puis : flutter pub get
```

---

## 📞 Support

Pour questions/bugs :

- 📧 Email: support@ayaclaude.app
- 🐛 GitHub Issues: [repo]/issues
- 💬 Discord: [community server]

---

## 📄 Licence

MIT License - Gratuit à usage commercial

---

## 🙏 Remerciements

- **Quran API** : Fawazahmed0
- **Hadith API** : Hadith Open Source Community
- **TinyLLaMA** : Meta AI
- **Flutter** : Google

---

**Prof AYA la Queen v2026**  
*Islamic Learning Companion - Offline First*

**Prêt à transformer l'apprentissage Islamique! 🚀**
