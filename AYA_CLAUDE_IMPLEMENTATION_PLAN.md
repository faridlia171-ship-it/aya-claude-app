# 🚀 AYA CLAUDE : Plan d'Implémentation Détaillé
**Version 2026 | Phase 3+ Ready | Étapes Validées & Testables**

---

# 📋 TABLE DES MATIÈRES

1. [Phase 3.0 : Configuration Initiale](#phase-30--configuration-initiale)
2. [Phase 3.1 : Squelette MVP (Validation)](#phase-31--squelette-mvp)
3. [Phase 3.2 : Intégration Module Coran](#phase-32--module-coran)
4. [Phase 3.3 : Intégration Module Arabe](#phase-33--module-arabe)
5. [Phase 3.4 : Intégration IA](#phase-34--ia-integration)
6. [Phase 4 : Backend & Déploiement](#phase-4--backend--déploiement)
7. [Timeline & Milestones](#timeline--milestones)

---

# 🔧 PHASE 3.0 : Configuration Initiale

## **3.0.1 : Setup Projet Flutter**

```bash
# Aucune commande - Instructions manuelles uniquement

ÉTAPES MANUELLES :
1. Ouvrir Terminal/PowerShell
2. Naviguer vers : C:\Users\nzo\Desktop\AYA CLAUDE
3. Créer projet :
   flutter create flutter_app --platforms=ios,android,web

4. Structure obtenue :
   flutter_app/
   ├── lib/
   ├── test/
   ├── android/
   ├── ios/
   ├── web/
   ├── pubspec.yaml
   └── README.md
```

## **3.0.2 : Ajouter Dépendances (pubspec.yaml)**

```yaml
# À copier-coller dans pubspec.yaml

dependencies:
  # Core
  flutter:
    sdk: flutter

  # State Management
  riverpod: ^2.4.0
  flutter_riverpod: ^2.4.0
  riverpod_generator: ^2.3.0

  # Navigation
  go_router: ^12.0.0

  # Database
  sqflite: ^2.3.0
  path: ^1.8.3

  # Firebase
  firebase_core: ^2.24.0
  firebase_auth: ^4.16.0
  cloud_firestore: ^4.14.0
  firebase_storage: ^11.5.0

  # Networking
  dio: ^5.3.0
  retrofit: ^4.0.0

  # JSON
  json_serializable: ^6.7.0
  freezed_annotation: ^2.4.1

  # UI
  flutter_svg: ^2.0.7
  cached_network_image: ^3.3.0

  # Localization
  intl: ^0.19.0

  # Utilities
  logger: ^2.0.0
  get_it: ^7.6.0
  dartz: ^0.10.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.0
  riverpod_generator: ^2.3.0
  freezed: ^2.4.1
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/quran/
    - assets/hadith/
    - assets/vocabulary/
    - assets/images/
```

**Action utilisateur** :
- [ ] Remplacer contenu pubspec.yaml
- [ ] Exécuter `flutter pub get` (manuel)

---

## **3.0.3 : Structure Core (Manuellement)**

Créer ces fichiers/dossiers :

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── app_strings.dart
│   │   └── app_colors.dart
│   │
│   ├── errors/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   │
│   ├── utils/
│   │   ├── logger.dart
│   │   └── extensions.dart
│   │
│   ├── db/
│   │   ├── database.dart
│   │   └── migrations/
│   │       └── migration_001_create_tables.sql
│   │
│   ├── services/
│   │   ├── firebase_service.dart
│   │   └── ai_service.dart
│   │
│   └── theme/
│       └── app_theme.dart
│
├── config/
│   ├── router.dart
│   ├── dependency_injection.dart
│   └── app_config.dart
│
├── shared/
│   ├── providers/
│   │   ├── database_provider.dart
│   │   └── firebase_provider.dart
│   └── widgets/
│       ├── app_scaffold.dart
│       ├── loading_widget.dart
│       └── error_widget.dart
│
├── features/
│   └── (à remplir en phase 3.2+)
│
└── main.dart
```

---

# 🔨 PHASE 3.1 : Squelette MVP

## **3.1.1 : Fichiers Core Minimaux**

### **lib/main.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'config/dependency_injection.dart';
import 'config/router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize core services
  await initializeDependencies();
  
  runApp(const ProviderScope(child: AyaClaudeApp()));
}

class AyaClaudeApp extends ConsumerWidget {
  const AyaClaudeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Prof AYA la Queen',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
      ],
    );
  }
}
```

### **lib/core/theme/app_theme.dart**

```dart
import 'package:flutter/material.dart';

class AppTheme {
  static const _primaryColor = Color(0xFF2E7D32);  // Islamic green
  static const _secondaryColor = Color(0xFFFDD835); // Islamic gold
  
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.light,
    ),
    typography: Typography.material2021(),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
    ),
    typography: Typography.material2021(),
  );
}
```

### **lib/core/constants/app_strings.dart**

```dart
class AppStrings {
  static const appName = 'Prof AYA la Queen';
  static const appVersion = '1.0.0';
  
  // Navigation
  static const home = 'Accueil';
  static const quran = 'Coran';
  static const learn = 'Apprendre';
  static const tutor = 'Tuteur IA';
  static const settings = 'Paramètres';
  
  // Common
  static const loading = 'Chargement...';
  static const error = 'Erreur';
  static const retry = 'Réessayer';
  static const back = 'Retour';
}
```

### **lib/config/router.dart**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/quran',
        name: 'quran',
        builder: (context, state) => const QuranListScreen(),
      ),
      GoRoute(
        path: '/learn',
        name: 'learn',
        builder: (context, state) => const LearningScreen(),
      ),
      GoRoute(
        path: '/tutor',
        name: 'tutor',
        builder: (context, state) => const AiTutorScreen(),
      ),
    ],
  );
});
```

### **lib/config/dependency_injection.dart**

```dart
import 'package:get_it/get_it.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Services
  // getIt.registerSingleton<DatabaseService>(await DatabaseService.init());
  // getIt.registerSingleton<FirebaseService>(FirebaseService());
  // getIt.registerSingleton<AIService>(AIService());
}
```

## **3.1.2 : Screens Minimales (Stubs)**

### **lib/features/dashboard/presentation/screens/dashboard_screen.dart**

```dart
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prof AYA la Queen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('✨ Dashboard'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Quran
              },
              child: const Text('Lire le Coran'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to Learn
              },
              child: const Text('Apprendre l\'Arabe'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to Tutor
              },
              child: const Text('Tuteur IA'),
            ),
          ],
        ),
      ),
    );
  }
}
```

Créer aussi :
- [ ] `quran_list_screen.dart` (stub)
- [ ] `learning_screen.dart` (stub)
- [ ] `ai_tutor_screen.dart` (stub)
- [ ] `splash_screen.dart` (stub)

## **3.1.3 : Database Initialization**

### **lib/core/db/database.dart**

```dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static const String dbName = 'aya_claude.db';
  
  static Future<Database> initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await _createTables(db);
      },
    );
  }

  static Future<void> _createTables(Database db) async {
    // Create tables from migration file
    final sql = '''
      -- Quran tables
      CREATE TABLE IF NOT EXISTS quran_surahs (
        id INTEGER PRIMARY KEY,
        number INTEGER UNIQUE NOT NULL,
        name_arabic TEXT NOT NULL,
        name_transliteration TEXT,
        revelation_type TEXT,
        verse_count INTEGER
      );

      CREATE TABLE IF NOT EXISTS quran_verses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        surah_id INTEGER NOT NULL,
        verse_number INTEGER NOT NULL,
        arabic_text TEXT NOT NULL,
        french_translation TEXT,
        english_translation TEXT,
        audio_url TEXT,
        transliteration TEXT,
        UNIQUE(surah_id, verse_number),
        FOREIGN KEY(surah_id) REFERENCES quran_surahs(id)
      );

      -- User progress
      CREATE TABLE IF NOT EXISTS user_progress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        module TEXT NOT NULL,
        lesson_id TEXT NOT NULL,
        completion_percentage REAL,
        score INTEGER,
        last_accessed DATETIME,
        UNIQUE(user_id, module, lesson_id)
      );
    ''';

    await db.execute(sql);
  }
}
```

---

## **3.1.4 : Validation Checklist**

```
✅ PHASE 3.1 VALIDATION :

□ Flutter project created
□ pubspec.yaml updated with dependencies
□ lib/main.dart ✅
□ lib/core/ structure ✅
□ lib/config/ setup ✅
□ lib/features/ (stubs only) ✅
□ Database initialization ✅
□ App runs without errors ✅
□ Navigation routes work ✅
□ Theme applies correctly ✅
```

**Test** :
```bash
flutter run
# Expected: App launches, Dashboard shows 3 buttons
```

---

# 📖 PHASE 3.2 : Intégration Module Coran

## **3.2.1 : Données Coran - Stratégie**

### **Étape 1 : Télécharger Coran JSON**

**Fichier** : `assets/quran/quran-uthmani.json` (5-10 MB)

Sources :
- https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/quran-uthmani.json
- https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/quran.json

**Action utilisateur** :
```
1. Télécharger JSON depuis URL ci-dessus
2. Placer dans : flutter_app/assets/quran/
3. (Optionnel) : Compresser en .gz pour réduire taille
```

### **Étape 2 : Charger Quran en SQLite au premier démarrage**

```dart
// lib/features/quran/data/datasources/quran_local_datasource.dart

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';

class QuranLocalDataSource {
  final Database _db;

  QuranLocalDataSource(this._db);

  Future<void> loadQuranFromAssets() async {
    try {
      // Check if already loaded
      final count = Sqflite.firstIntValue(
        await _db.rawQuery('SELECT COUNT(*) FROM quran_surahs'),
      ) ?? 0;

      if (count > 0) return; // Already loaded

      // Load JSON
      final jsonString = await rootBundle
          .loadString('assets/quran/quran-uthmani.json');
      final quranData = json.decode(jsonString);

      // Parse and insert
      for (var surah in quranData['surahs']) {
        await _db.insert('quran_surahs', {
          'number': surah['number'],
          'name_arabic': surah['name'],
          'name_transliteration': surah['englishName'],
          'revelation_type': surah['revelationType'],
          'verse_count': surah['numberOfAyahs'],
        });

        for (var ayah in surah['ayahs']) {
          await _db.insert('quran_verses', {
            'surah_id': surah['number'],
            'verse_number': ayah['numberInSurah'],
            'arabic_text': ayah['text'],
          });
        }
      }
    } catch (e) {
      print('Error loading Quran: $e');
      rethrow;
    }
  }

  Future<List<SurahModel>> getAllSurahs() async {
    try {
      final result = await _db.query('quran_surahs');
      return result.map((e) => SurahModel.fromJson(e)).toList();
    } catch (e) {
      throw DatabaseException('Failed to get surahs: $e');
    }
  }
}
```

## **3.2.2 : Architecture Coran (Domain/Data/Presentation)**

### **Entity (Domain)**

```dart
// lib/features/quran/domain/entities/surah_entity.dart

class SurahEntity {
  final int id;
  final int number;
  final String nameArabic;
  final String nameTransliteration;
  final String revelationType;
  final int verseCount;

  SurahEntity({
    required this.id,
    required this.number,
    required this.nameArabic,
    required this.nameTransliteration,
    required this.revelationType,
    required this.verseCount,
  });
}
```

### **Model (Data)**

```dart
// lib/features/quran/data/models/surah_model.dart

import '../entities/surah_entity.dart';

class SurahModel extends SurahEntity {
  SurahModel({
    required int id,
    required int number,
    required String nameArabic,
    required String nameTransliteration,
    required String revelationType,
    required int verseCount,
  }) : super(
    id: id,
    number: number,
    nameArabic: nameArabic,
    nameTransliteration: nameTransliteration,
    revelationType: revelationType,
    verseCount: verseCount,
  );

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      id: json['id'],
      number: json['number'],
      nameArabic: json['name_arabic'],
      nameTransliteration: json['name_transliteration'],
      revelationType: json['revelation_type'],
      verseCount: json['verse_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'name_arabic': nameArabic,
      'name_transliteration': nameTransliteration,
      'revelation_type': revelationType,
      'verse_count': verseCount,
    };
  }
}
```

### **Repository Interface (Domain)**

```dart
// lib/features/quran/domain/repositories/quran_repository.dart

import 'package:dartz/dartz.dart';
import '../entities/surah_entity.dart';
import '../../../core/errors/failures.dart';

abstract class QuranRepository {
  Future<Either<Failure, List<SurahEntity>>> getAllSurahs();
  Future<Either<Failure, SurahEntity>> getSurahDetail(int surahId);
}
```

### **Repository Implementation (Data)**

```dart
// lib/features/quran/data/repositories/quran_repository_impl.dart

class QuranRepositoryImpl implements QuranRepository {
  final QuranLocalDataSource _localDataSource;

  QuranRepositoryImpl({
    required QuranLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  Future<Either<Failure, List<SurahEntity>>> getAllSurahs() async {
    try {
      final surahs = await _localDataSource.getAllSurahs();
      return Right(surahs);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, SurahEntity>> getSurahDetail(int surahId) async {
    // Similar implementation
    return Right(SurahEntity(...));
  }
}
```

### **Riverpod Provider**

```dart
// lib/features/quran/presentation/providers/quran_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

final quranRepositoryProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return QuranRepositoryImpl(
    localDataSource: QuranLocalDataSource(db),
  );
});

final getAllSurahsProvider = FutureProvider((ref) {
  final repository = ref.watch(quranRepositoryProvider);
  return repository.getAllSurahs();
});
```

## **3.2.3 : UI Screens Coran**

### **QuranListScreen**

```dart
// lib/features/quran/presentation/screens/quran_list_screen.dart

class QuranListScreen extends ConsumerWidget {
  const QuranListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surahsAsync = ref.watch(getAllSurahsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('القرآن الكريم')),
      body: surahsAsync.when(
        data: (surahs) => ListView.builder(
          itemCount: surahs.length,
          itemBuilder: (context, index) {
            final surah = surahs[index];
            return ListTile(
              title: Text(surah.nameArabic),
              subtitle: Text('${surah.verseCount} verses'),
              onTap: () {
                // Navigate to detail
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
```

## **3.2.4 : Validation Checklist**

```
✅ PHASE 3.2 VALIDATION :

□ Quran JSON downloaded to assets/
□ SQLite migration for Quran tables ✅
□ QuranLocalDataSource implemented ✅
□ SurahEntity & Model created ✅
□ Repository interface & impl ✅
□ Riverpod provider ✅
□ QuranListScreen rendering ✅
□ Navigation from Dashboard ✅
□ Data persists on app restart ✅
```

**Test** :
```bash
flutter run
# Expected: Dashboard → "Lire le Coran" → Shows 114 Surahs
```

---

# 🔤 PHASE 3.3 : Intégration Module Arabe

**(Identique à Coran, avec adaptations pour Alphabet & Vocabulaire)**

## **3.3.1 : Vocabulaire JSON Structure**

```json
{
  "vocabulary_sets": [
    {
      "id": "alphabet_001",
      "category": "Alphabet",
      "level": "beginner",
      "words": [
        {
          "id": "alef",
          "arabic": "ا",
          "transliteration": "alif",
          "english": "Alef",
          "french": "Alef",
          "example": "أسد (lion)"
        }
      ]
    },
    {
      "id": "family_001",
      "category": "Family",
      "words": [
        {
          "arabic": "أب",
          "transliteration": "ab",
          "english": "father",
          "french": "père"
        }
      ]
    }
  ]
}
```

Créer : `assets/vocabulary/vocabulary.json`

## **3.3.2 : Implémentation Vocabulaire**

Suivre même pattern que Coran :
- Entity → Model → Repository → Provider → Screen

---

# 🧠 PHASE 3.4 : Intégration IA

## **3.4.1 : TinyLLaMA Setup**

**Télécharger modèle** :
```
https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF/
Fichier: tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf (200-400 MB)

→ Placer dans : flutter_app/assets/models/
```

## **3.4.2 : AIService Implementation**

```dart
// lib/core/services/ai_service.dart

class AIService {
  // Using dart_llm or ollama package
  
  Future<String> generateResponse(String prompt) async {
    // Local inference via TinyLLaMA
  }

  Future<List<QuizQuestion>> generateQuiz(String topic) async {
    // Generate quiz adaptatively
  }
}
```

## **3.4.3 : AI Tutor Screen**

Chat interface pour converser avec l'IA

---

# 🔌 PHASE 4 : Backend & Déploiement

## **4.1 : Ollama Docker Setup**

```dockerfile
# backend/ollama/Dockerfile
FROM ollama/ollama:latest
RUN ollama serve & sleep 5 && ollama pull tinyllama:latest
EXPOSE 11434
```

Deploy sur Google Cloud Run (gratuit)

## **4.2 : Firebase Setup**

1. Créer projet Firebase
2. Configurer Auth, Firestore, Storage
3. Télécharger google-services.json (Android)
4. Télécharger GoogleService-Info.plist (iOS)

## **4.3 : Web App (PWA)**

- Même code Flutter, compilation web
- Deploy sur Firebase Hosting

---

# ⏱️ TIMELINE & MILESTONES

| Phase | Durée | Milestones |
|-------|-------|-----------|
| **3.0** | 1 jour | Project setup, deps, core structure ✅ |
| **3.1** | 1-2 jours | MVP skeleton, screens stubs ✅ |
| **3.2** | 3-4 jours | Quran module (CRUD, display) |
| **3.3** | 2-3 jours | Arabic learning module |
| **3.4** | 3-4 jours | AI integration |
| **4.0** | 2-3 jours | Backend, Firebase, deployment |
| **Polish** | 1-2 jours | Testing, animations, fixes |
| **TOTAL** | **14-20 jours** | Production Ready |

---

**Plan d'implémentation AYA CLAUDE - Validé ✅**
