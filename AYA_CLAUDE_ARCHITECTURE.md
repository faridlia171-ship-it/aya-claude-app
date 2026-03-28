# 🏗️ AYA CLAUDE : Architecture Technique Complète
**Version 2026 | Clean Architecture + Riverpod + Firebase + IA Offline**

---

# 📐 PART 1 : ARCHITECTURE GLOBALE

## **Vue d'ensemble Système**

```
┌───────────────────────────────────────────────────────────┐
│                   AYA CLAUDE ECOSYSTEM                    │
└───────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│          MOBILE APPS (iOS/Android/Web)                  │
│                    FLUTTER                              │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌─────────────────────────────────────────────────┐   │
│  │         PRESENTATION LAYER                      │   │
│  │  (Screens, Widgets, Navigation)                 │   │
│  └──────────────────┬──────────────────────────────┘   │
│                    │                                    │
│  ┌─────────────────▼──────────────────────────────┐   │
│  │    APPLICATION/DOMAIN LAYER                    │   │
│  │  • Riverpod Providers (State Management)        │   │
│  │  • Use Cases & Repositories                    │   │
│  │  • Business Logic                              │   │
│  └──────────────────┬──────────────────────────────┘   │
│                    │                                    │
│  ┌─────────────────▼──────────────────────────────┐   │
│  │       DATA LAYER                               │   │
│  │  ┌──────────────────────────────────────────┐   │   │
│  │  │ SQLite Local (Offline-First)            │   │   │
│  │  │ • Quran, Hadith, Vocabulary             │   │   │
│  │  │ • User Progress, Bookmarks              │   │   │
│  │  └──────────────────────────────────────────┘   │   │
│  │  ┌──────────────────────────────────────────┐   │   │
│  │  │ Firebase Sync (When online)              │   │   │
│  │  │ • Firestore (Progression user)           │   │   │
│  │  │ • Cloud Storage (Médias additionnels)    │   │   │
│  │  │ • Remote Config (Contenu dynamique)      │   │   │
│  │  └──────────────────────────────────────────┘   │   │
│  │  ┌──────────────────────────────────────────┐   │   │
│  │  │ IA Local                                 │   │   │
│  │  │ • TinyLLaMA (GGML)                       │   │   │
│  │  │ • Inference via Dart FFI                 │   │   │
│  │  └──────────────────────────────────────────┘   │   │
│  └─────────────────────────────────────────────────┘   │
│                                                         │
└─────────────────────────────────────────────────────────┘
         │                           │
         │                           │
   ┌─────▼──────┐          ┌────────▼─────────┐
   │   Firebase │          │  Google Cloud    │
   │   Services │          │  (Ollama Backend)│
   └────────────┘          └──────────────────┘
```

---

# 📁 PART 2 : STRUCTURE FLUTTER COMPLÈTE

## **Arborescence Recommandée**

```
AYA_CLAUDE/
│
├── flutter_app/                          # App mobile/desktop
│   ├── lib/
│   │   ├── main.dart                     # Point d'entrée
│   │   │
│   │   ├── core/                         # Logique réutilisable
│   │   │   ├── constants/
│   │   │   │   ├── app_constants.dart    # URLs, keys, configuration
│   │   │   │   ├── app_strings.dart      # Textes (i18n)
│   │   │   │   └── app_colors.dart       # Palette design
│   │   │   │
│   │   │   ├── errors/
│   │   │   │   ├── exceptions.dart       # Custom exceptions
│   │   │   │   └── failures.dart         # Failure models
│   │   │   │
│   │   │   ├── utils/
│   │   │   │   ├── logger.dart           # Logging utility
│   │   │   │   ├── validators.dart       # Validation (email, etc)
│   │   │   │   ├── formatters.dart       # Date, nombre formatage
│   │   │   │   └── extensions.dart       # String, num extensions
│   │   │   │
│   │   │   ├── db/
│   │   │   │   ├── database.dart         # SQLite setup
│   │   │   │   ├── migrations/
│   │   │   │   │   ├── migration_001_create_tables.sql
│   │   │   │   │   └── migration_002_add_bookmarks.sql
│   │   │   │   └── database_client.dart  # Wrapper
│   │   │   │
│   │   │   ├── network/
│   │   │   │   ├── http_client.dart      # Dio config
│   │   │   │   └── interceptors.dart     # Auth, logging
│   │   │   │
│   │   │   ├── services/
│   │   │   │   ├── firebase_service.dart # Firebase initialization
│   │   │   │   ├── analytics_service.dart
│   │   │   │   ├── ai_service.dart       # TinyLLaMA wrapper
│   │   │   │   └── storage_service.dart  # Local preferences
│   │   │   │
│   │   │   └── theme/
│   │   │       ├── app_theme.dart        # ThemeData
│   │   │       └── theme_notifier.dart   # Dark/Light toggle
│   │   │
│   │   ├── features/                     # Modules fonctionnels
│   │   │   │
│   │   │   ├── auth/
│   │   │   │   ├── data/
│   │   │   │   │   ├── datasources/
│   │   │   │   │   │   ├── firebase_auth_datasource.dart
│   │   │   │   │   │   └── local_auth_datasource.dart
│   │   │   │   │   ├── models/
│   │   │   │   │   │   └── user_model.dart (extends entity)
│   │   │   │   │   └── repositories/
│   │   │   │   │       └── auth_repository_impl.dart
│   │   │   │   │
│   │   │   │   ├── domain/
│   │   │   │   │   ├── entities/
│   │   │   │   │   │   └── user_entity.dart
│   │   │   │   │   ├── repositories/
│   │   │   │   │   │   └── auth_repository.dart (abstract)
│   │   │   │   │   └── usecases/
│   │   │   │   │       ├── login_usecase.dart
│   │   │   │   │       ├── register_usecase.dart
│   │   │   │   │       └── logout_usecase.dart
│   │   │   │   │
│   │   │   │   └── presentation/
│   │   │   │       ├── providers/
│   │   │   │       │   └── auth_provider.dart (Riverpod)
│   │   │   │       ├── screens/
│   │   │   │       │   ├── login_screen.dart
│   │   │   │       │   ├── register_screen.dart
│   │   │   │       │   └── splash_screen.dart
│   │   │   │       └── widgets/
│   │   │   │           └── login_form.dart
│   │   │   │
│   │   │   ├── quran/
│   │   │   │   ├── data/
│   │   │   │   │   ├── datasources/
│   │   │   │   │   │   ├── quran_local_datasource.dart
│   │   │   │   │   │   └── quran_remote_datasource.dart
│   │   │   │   │   ├── models/
│   │   │   │   │   │   ├── surah_model.dart
│   │   │   │   │   │   ├── ayah_model.dart
│   │   │   │   │   │   └── tafsir_model.dart
│   │   │   │   │   └── repositories/
│   │   │   │   │       └── quran_repository_impl.dart
│   │   │   │   │
│   │   │   │   ├── domain/
│   │   │   │   │   ├── entities/
│   │   │   │   │   │   ├── surah_entity.dart
│   │   │   │   │   │   ├── ayah_entity.dart
│   │   │   │   │   │   └── tafsir_entity.dart
│   │   │   │   │   ├── repositories/
│   │   │   │   │   │   └── quran_repository.dart (abstract)
│   │   │   │   │   └── usecases/
│   │   │   │   │       ├── get_all_surahs_usecase.dart
│   │   │   │   │       ├── get_surah_detail_usecase.dart
│   │   │   │   │       ├── get_ayah_usecase.dart
│   │   │   │   │       ├── search_ayah_usecase.dart
│   │   │   │   │       └── add_bookmark_usecase.dart
│   │   │   │   │
│   │   │   │   └── presentation/
│   │   │   │       ├── providers/
│   │   │   │       │   ├── quran_provider.dart
│   │   │   │       │   ├── surah_detail_provider.dart
│   │   │   │       │   └── bookmark_provider.dart
│   │   │   │       ├── screens/
│   │   │   │       │   ├── quran_list_screen.dart
│   │   │   │       │   ├── surah_detail_screen.dart
│   │   │   │       │   └── search_screen.dart
│   │   │   │       └── widgets/
│   │   │   │           ├── surah_card.dart
│   │   │   │           ├── ayah_tile.dart
│   │   │   │           └── ayah_detail_panel.dart
│   │   │   │
│   │   │   ├── arabic_learning/
│   │   │   │   ├── data/
│   │   │   │   │   ├── datasources/
│   │   │   │   │   │   └── vocabulary_datasource.dart
│   │   │   │   │   ├── models/
│   │   │   │   │   │   ├── alphabet_model.dart
│   │   │   │   │   │   ├── vocabulary_model.dart
│   │   │   │   │   │   ├── grammar_rule_model.dart
│   │   │   │   │   │   └── lesson_model.dart
│   │   │   │   │   └── repositories/
│   │   │   │   │       └── learning_repository_impl.dart
│   │   │   │   │
│   │   │   │   ├── domain/
│   │   │   │   │   ├── entities/ (Alphabet, Vocabulary, Grammar entities)
│   │   │   │   │   ├── repositories/
│   │   │   │   │   │   └── learning_repository.dart (abstract)
│   │   │   │   │   └── usecases/
│   │   │   │   │       ├── get_alphabet_usecase.dart
│   │   │   │   │       ├── get_vocabulary_set_usecase.dart
│   │   │   │   │       ├── get_grammar_rule_usecase.dart
│   │   │   │   │       └── complete_lesson_usecase.dart
│   │   │   │   │
│   │   │   │   └── presentation/
│   │   │   │       ├── providers/
│   │   │   │       │   ├── lesson_provider.dart
│   │   │   │       │   └── progress_provider.dart
│   │   │   │       ├── screens/
│   │   │   │       │   ├── alphabet_screen.dart
│   │   │   │       │   ├── vocabulary_screen.dart
│   │   │   │       │   ├── grammar_screen.dart
│   │   │   │       │   └── lesson_progress_screen.dart
│   │   │   │       └── widgets/
│   │   │   │           ├── letter_card.dart
│   │   │   │           ├── vocabulary_card.dart
│   │   │   │           └── progress_indicator.dart
│   │   │   │
│   │   │   ├── hadith/
│   │   │   │   ├── data/
│   │   │   │   │   ├── datasources/
│   │   │   │   │   │   ├── hadith_local_datasource.dart
│   │   │   │   │   │   └── hadith_remote_datasource.dart
│   │   │   │   │   ├── models/
│   │   │   │   │   │   ├── collection_model.dart
│   │   │   │   │   │   ├── hadith_model.dart
│   │   │   │   │   │   └── chapter_model.dart
│   │   │   │   │   └── repositories/
│   │   │   │   │       └── hadith_repository_impl.dart
│   │   │   │   │
│   │   │   │   ├── domain/
│   │   │   │   │   ├── entities/
│   │   │   │   │   ├── repositories/
│   │   │   │   │   │   └── hadith_repository.dart (abstract)
│   │   │   │   │   └── usecases/
│   │   │   │   │       ├── get_hadith_collections_usecase.dart
│   │   │   │   │       ├── get_hadith_by_id_usecase.dart
│   │   │   │   │       └── search_hadith_usecase.dart
│   │   │   │   │
│   │   │   │   └── presentation/
│   │   │   │       ├── providers/
│   │   │   │       │   └── hadith_provider.dart
│   │   │   │       ├── screens/
│   │   │   │       │   ├── hadith_list_screen.dart
│   │   │   │       │   └── hadith_detail_screen.dart
│   │   │   │       └── widgets/
│   │   │   │           └── hadith_card.dart
│   │   │   │
│   │   │   ├── ai_tutor/
│   │   │   │   ├── data/
│   │   │   │   │   ├── datasources/
│   │   │   │   │   │   ├── ai_local_datasource.dart (TinyLLaMA)
│   │   │   │   │   │   └── ai_remote_datasource.dart (Cloud Functions)
│   │   │   │   │   ├── models/
│   │   │   │   │   │   ├── ai_message_model.dart
│   │   │   │   │   │   ├── quiz_model.dart
│   │   │   │   │   │   └── ai_response_model.dart
│   │   │   │   │   └── repositories/
│   │   │   │   │       └── ai_repository_impl.dart
│   │   │   │   │
│   │   │   │   ├── domain/
│   │   │   │   │   ├── entities/
│   │   │   │   │   ├── repositories/
│   │   │   │   │   │   └── ai_repository.dart (abstract)
│   │   │   │   │   └── usecases/
│   │   │   │   │       ├── ask_ai_usecase.dart
│   │   │   │   │       ├── generate_quiz_usecase.dart
│   │   │   │   │       ├── evaluate_answer_usecase.dart
│   │   │   │   │       └── get_explanation_usecase.dart
│   │   │   │   │
│   │   │   │   └── presentation/
│   │   │   │       ├── providers/
│   │   │   │       │   ├── ai_chat_provider.dart (Riverpod)
│   │   │   │       │   └── quiz_provider.dart
│   │   │   │       ├── screens/
│   │   │   │       │   ├── ai_tutor_screen.dart
│   │   │   │       │   ├── quiz_screen.dart
│   │   │   │       │   └── quiz_results_screen.dart
│   │   │   │       └── widgets/
│   │   │   │           ├── chat_bubble.dart
│   │   │   │           ├── quiz_question.dart
│   │   │   │           └── loading_indicator.dart
│   │   │   │
│   │   │   ├── dashboard/
│   │   │   │   ├── presentation/
│   │   │   │   │   ├── providers/
│   │   │   │   │   │   └── dashboard_provider.dart
│   │   │   │   │   ├── screens/
│   │   │   │   │   │   └── dashboard_screen.dart
│   │   │   │   │   └── widgets/
│   │   │   │   │       ├── progress_widget.dart
│   │   │   │   │       ├── quick_access_widget.dart
│   │   │   │   │       └── achievements_widget.dart
│   │   │   │   └── data/
│   │   │   │       └── models/
│   │   │   │           └── dashboard_stats_model.dart
│   │   │   │
│   │   │   └── settings/
│   │   │       ├── presentation/
│   │   │       │   ├── screens/
│   │   │       │   │   └── settings_screen.dart
│   │   │       │   └── widgets/
│   │   │       │       ├── language_selector.dart
│   │   │       │       └── theme_toggle.dart
│   │   │       └── data/
│   │   │           └── models/
│   │   │               └── user_preferences_model.dart
│   │   │
│   │   ├── config/
│   │   │   ├── router.dart                # Route definitions (go_router)
│   │   │   ├── dependency_injection.dart  # Setup providers Riverpod
│   │   │   └── app_config.dart            # Environment config
│   │   │
│   │   ├── shared/
│   │   │   ├── providers/
│   │   │   │   ├── database_provider.dart
│   │   │   │   ├── http_client_provider.dart
│   │   │   │   ├── firebase_provider.dart
│   │   │   │   └── ai_provider.dart
│   │   │   │
│   │   │   ├── models/
│   │   │   │   └── pagination_model.dart
│   │   │   │
│   │   │   └── widgets/
│   │   │       ├── app_scaffold.dart
│   │   │       ├── loading_widget.dart
│   │   │       ├── error_widget.dart
│   │   │       └── custom_appbar.dart
│   │   │
│   │   └── generated/
│   │       └── (Generated code - riverpod, hive, etc)
│   │
│   ├── pubspec.yaml                       # Dépendances
│   ├── test/                              # Unit & Widget tests
│   └── integration_test/                  # Integration tests
│
├── web_app/                               # Site web / PWA
│   ├── lib/
│   │   ├── main_web.dart
│   │   ├── web_specific/
│   │   │   └── web_routes.dart
│   │   └── (Partagé avec mobile)
│   ├── web/
│   │   ├── index.html
│   │   └── styles/
│   └── pubspec.yaml
│
├── backend/                               # Backend serveurs
│   │
│   ├── ollama/
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
│   │   └── README.md (Deploy sur Cloud Run)
│   │
│   ├── cloud_functions/
│   │   ├── functions/
│   │   │   ├── ai_inference.js
│   │   │   ├── sync_user_data.js
│   │   │   └── generate_quiz.js
│   │   ├── .firebaserc
│   │   └── firebase.json
│   │
│   └── scripts/
│       ├── deploy_ollama.sh
│       └── setup_firebase.sh
│
├── assets/                                # Ressources pédagogiques
│   ├── quran/
│   │   ├── quran-uthmani.json (gzipped)
│   │   └── quran-fr-hamidullah.json
│   ├── hadith/
│   │   ├── hadith-bukhari.json
│   │   └── hadith-muslim.json
│   ├── vocabulary/
│   │   ├── alphabet.json
│   │   └── vocabulary-sets.json
│   ├── audio/
│   │   └── (TBD - Audio files URLs or bundled)
│   ├── images/
│   │   ├── splash.png
│   │   ├── icons/
│   │   └── illustrations/
│   ├── fonts/
│   │   ├── ArabicFont.ttf
│   │   └── ArabicFontBold.ttf
│   └── models/
│       └── tinyllama-1.1b-q4.gguf (200-400 MB)
│
├── docs/
│   ├── ARCHITECTURE.md                    # This file
│   ├── SETUP.md                           # Installation guide
│   ├── API_INTEGRATION.md                 # API endpoints
│   ├── DATABASE_SCHEMA.md                 # DB structure
│   ├── AI_INTEGRATION.md                  # AI setup
│   ├── FIREBASE_CONFIG.md                 # Firebase setup
│   ├── DEPLOYMENT.md                      # Deploy guide
│   └── CONTRIBUTING.md                    # Contribution guidelines
│
├── .github/
│   └── workflows/
│       ├── build.yml                      # CI/CD
│       ├── tests.yml
│       └── deploy.yml
│
├── README.md                              # Project overview
└── pubspec.yaml (root - if monorepo)
```

---

# 🔧 PART 3 : DÉPENDANCES FLUTTER (pubspec.yaml)

## **Dépendances Principales**

```yaml
name: aya_claude
description: Prof AYA la Queen - Islamic Learning App
version: 1.0.0

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # 🎯 STATE MANAGEMENT
  riverpod: ^2.4.0
  flutter_riverpod: ^2.4.0
  riverpod_generator: ^2.3.0

  # 📱 NAVIGATION
  go_router: ^12.0.0

  # 💾 LOCAL DATABASE
  sqflite: ^2.3.0
  sqlite3_flutter_libs: ^0.5.0
  path: ^1.8.3
  
  # 🔥 FIREBASE
  firebase_core: ^2.24.0
  firebase_auth: ^4.16.0
  cloud_firestore: ^4.14.0
  firebase_storage: ^11.5.0
  firebase_analytics: ^10.7.0
  firebase_remote_config: ^4.4.0

  # 🌐 NETWORKING
  dio: ^5.3.0
  retrofit: ^4.0.0
  
  # 📦 JSON SERIALIZATION
  json_serializable: ^6.7.0
  freezed_annotation: ^2.4.1

  # 🎨 UI & DESIGN
  flutter_svg: ^2.0.7
  cached_network_image: ^3.3.0
  smooth_page_indicator: ^1.1.0
  flutter_staggered_grid_view: ^0.7.0
  
  # 🗣️ INTERNATIONALIZATION
  intl: ^0.19.0
  flutter_localizations:
    sdk: flutter

  # 🔐 SECURITY
  flutter_keychain: ^2.4.0
  encrypt: ^5.0.1

  # 🧠 AI/ML
  dart_llm: ^0.1.0  # For running TinyLLaMA locally
  # OR
  # ollama: ^0.1.0  # Alternative Ollama client

  # 📊 LOGGING & ANALYTICS
  logger: ^2.0.0
  mixpanel_flutter: ^4.1.0

  # 🎵 AUDIO
  just_audio: ^0.9.31
  audio_session: ^0.1.16

  # 🔔 NOTIFICATIONS
  flutter_local_notifications: ^16.2.0

  # 📝 FORMS & VALIDATION
  formz: ^0.6.0

  # 🛠️ UTILITIES
  get_it: ^7.6.0
  dartz: ^0.10.1
  equatable: ^2.0.5

dev_dependencies:
  flutter_test:
    sdk: flutter

  # 🧪 TESTING
  mocktail: ^1.0.0
  bloc_test: ^9.1.0

  # 📝 CODE GENERATION
  build_runner: ^2.4.0
  riverpod_generator: ^2.3.0
  freezed: ^2.4.1

  # 🔍 CODE ANALYSIS
  flutter_lints: ^3.0.0
  very_good_analysis: ^6.0.0

  # 📄 DOCUMENTATION
  dartdoc: ^7.0.0

flutter:
  uses-material-design: true
  
  assets:
    - assets/quran/
    - assets/hadith/
    - assets/vocabulary/
    - assets/images/
    - assets/models/
  
  fonts:
    - family: ArabicFont
      fonts:
        - asset: assets/fonts/ArabicFont.ttf
        - asset: assets/fonts/ArabicFontBold.ttf
          weight: 700
```

---

# 🔄 PART 4 : DATA FLOW & RIVERPOD PATTERN

## **Pattern Provider Riverpod**

### **1. Repository Provider**
```dart
// lib/config/dependency_injection.dart

final quranRepositoryProvider = Provider<QuranRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final httpClient = ref.watch(httpClientProvider);
  return QuranRepositoryImpl(
    localDataSource: QuranLocalDataSource(db),
    remoteDataSource: QuranRemoteDataSource(httpClient),
  );
});
```

### **2. Use Case Provider**
```dart
final getAllSurahsUseCaseProvider = Provider((ref) {
  final repository = ref.watch(quranRepositoryProvider);
  return GetAllSurahsUseCase(repository);
});
```

### **3. StateNotifier Provider (Observable State)**
```dart
// lib/features/quran/presentation/providers/quran_provider.dart

final quranListProvider = StateNotifierProvider<
  QuranListNotifier,
  AsyncValue<List<SurahEntity>>
>((ref) {
  final useCase = ref.watch(getAllSurahsUseCaseProvider);
  return QuranListNotifier(useCase);
});

class QuranListNotifier extends StateNotifier<AsyncValue<List<SurahEntity>>> {
  final GetAllSurahsUseCase _useCase;

  QuranListNotifier(this._useCase) : super(const AsyncValue.loading()) {
    _loadSurahs();
  }

  Future<void> _loadSurahs() async {
    final result = await _useCase();
    
    result.fold(
      (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
      },
      (surahs) {
        state = AsyncValue.data(surahs);
      },
    );
  }
}
```

### **4. Filtered Provider (Search)**
```dart
final searchSurahProvider = StateProvider<String>((ref) => '');

final filteredSurahsProvider = Provider<AsyncValue<List<SurahEntity>>>((ref) {
  final surahs = ref.watch(quranListProvider);
  final query = ref.watch(searchSurahProvider);

  return surahs.whenData((list) {
    return list
        .where((s) => s.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  });
});
```

---

# 💬 PART 5 : AI INTEGRATION PATTERN

## **TinyLLaMA Local Inference**

```dart
// lib/core/services/ai_service.dart

class AIService {
  late final LLMModel _model;
  final String modelPath = 'assets/models/tinyllama-1.1b-q4.gguf';
  
  Future<void> initialize() async {
    _model = await LLMModel.load(modelPath);
  }

  Future<String> askQuestion(String question) async {
    try {
      final response = await _model.generate(
        prompt: _buildPrompt(question),
        maxTokens: 200,
        temperature: 0.7,
      );
      return response.text;
    } catch (e) {
      throw AIException('Failed to generate response: $e');
    }
  }

  String _buildPrompt(String question) {
    return '''You are Prof AYA, an expert Islamic studies and Arabic language teacher.
    
    Answer this question about Arabic or Islam:
    $question
    
    Keep answer concise (2-3 sentences max) and educational.
    Use simple, clear language.''';
  }

  Future<List<QuizQuestion>> generateQuiz({
    required String topic,
    required int count,
  }) async {
    final prompt = '''Generate $count multiple choice quiz questions about: $topic
    
    Format as JSON array:
    [
      {
        "question": "...",
        "options": ["A", "B", "C", "D"],
        "correct": 0,
        "explanation": "..."
      }
    ]''';

    final response = await _model.generate(
      prompt: prompt,
      maxTokens: 1000,
    );
    
    return _parseQuizJSON(response.text);
  }
}
```

---

# ✅ PART 6 : CHECKLIST IMPLÉMENTATION

## **Phase 1 : Configuration de Base**
- [ ] Create Flutter project structure
- [ ] Setup Riverpod dependency injection
- [ ] Configure Firebase (Auth, Firestore, Storage)
- [ ] Setup SQLite database with migrations
- [ ] Create app routing (go_router)

## **Phase 2 : Core Features**
- [ ] Implement Quran module (CRUD operations)
- [ ] Implement Hadith module
- [ ] Implement Arabic learning module (Alphabet, Vocabulary)
- [ ] Create Dashboard UI

## **Phase 3 : IA Integration**
- [ ] Integrate TinyLLaMA model
- [ ] Implement AI chat interface
- [ ] Create quiz generation system
- [ ] Build evaluation system

## **Phase 4 : Backend & Sync**
- [ ] Setup Ollama Docker container
- [ ] Deploy on Google Cloud Run
- [ ] Implement Firebase Firestore sync
- [ ] Create Cloud Functions (if needed)

## **Phase 5 : Polish & Deploy**
- [ ] Implement offline-first strategy
- [ ] Add animations & transitions
- [ ] Perform security audit
- [ ] Build for iOS/Android/Web
- [ ] Setup CI/CD pipeline

---

**Architecture Document - AYA CLAUDE v2026**  
**Clean Architecture + Riverpod + Firebase + IA Offline**
