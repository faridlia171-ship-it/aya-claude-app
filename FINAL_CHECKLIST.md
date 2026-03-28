# ✅ CHECKLIST FINAL - Prof AYA la Queen

**Tout ce que vous devez faire pour lancer l'app en production**

---

## 📋 PHASE 1 : Setup Environnement (30 min)

### Prerequisites
- [ ] Flutter SDK 3.x installé (`flutter --version`)
- [ ] Dart SDK 3.x installé (`dart --version`)
- [ ] Android SDK / Xcode installé (selon la plateforme)
- [ ] Un éditeur (VS Code + Flutter extension OU Android Studio)

### Créer le Projet
- [ ] Créer nouveau projet : `flutter create flutter_app`
- [ ] Naviguer : `cd flutter_app`
- [ ] Vérifier la structure : `ls -la`

---

## 📁 PHASE 2 : Copier les Fichiers (20 min)

### Configuration
- [ ] Télécharger `pubspec.yaml` → Remplacer `/pubspec.yaml`
- [ ] Exécuter : `flutter pub get` (Attendre 2-5 min)
- [ ] Vérifier : `flutter pub list` → Doit lister 40+ packages

### Structure Core
- [ ] Créer dossier : `lib/core/theme/`
- [ ] Créer dossier : `lib/core/constants/`
- [ ] Créer dossier : `lib/core/db/`
- [ ] Créer dossier : `lib/core/services/`
- [ ] Créer dossier : `lib/config/`

Copier les fichiers :
- [ ] `lib_main.dart` → `lib/main.dart`
- [ ] `core_theme_app_theme.dart` → `lib/core/theme/app_theme.dart`
- [ ] `core_constants_app_strings.dart` → `lib/core/constants/app_strings.dart`
- [ ] `core_db_database_service.dart` → `lib/core/db/database_service.dart`
- [ ] `core_services_ai_service.dart` → `lib/core/services/ai_service.dart`
- [ ] `core_services_logger_service.dart` → `lib/core/services/logger_service.dart`
- [ ] `config_router.dart` → `lib/config/router.dart`
- [ ] `config_dependency_injection.dart` → `lib/config/dependency_injection.dart`
- [ ] `config_app_initializer.dart` → `lib/config/app_initializer.dart`
- [ ] `config_app_providers.dart` → `lib/config/app_providers.dart`

### Structures Features
- [ ] Créer `lib/features/splash/presentation/screens/`
- [ ] Créer `lib/features/dashboard/presentation/screens/`
- [ ] Créer `lib/features/quran/presentation/screens/`
- [ ] Créer `lib/features/arabic_learning/presentation/screens/`
- [ ] Créer `lib/features/ai_tutor/presentation/screens/`
- [ ] Créer `lib/features/hadith/presentation/screens/`
- [ ] Créer `lib/features/settings/presentation/screens/`

Copier les screens :
- [ ] `features_splash_splash_screen.dart` → `lib/features/splash/presentation/screens/splash_screen.dart`
- [ ] `features_dashboard_dashboard_screen.dart` → `lib/features/dashboard/presentation/screens/dashboard_screen.dart`
- [ ] `features_quran_quran_list_screen.dart` → `lib/features/quran/presentation/screens/quran_list_screen.dart`
- [ ] `features_quran_surah_detail_screen.dart` → `lib/features/quran/presentation/screens/surah_detail_screen.dart`
- [ ] `features_arabic_learning_screen.dart` → `lib/features/arabic_learning/presentation/screens/learning_screen.dart`
- [ ] `features_ai_tutor_screen.dart` → `lib/features/ai_tutor/presentation/screens/ai_tutor_screen.dart`
- [ ] `features_hadith_and_settings.dart` → `lib/features/hadith/presentation/screens/hadith_list_screen.dart` + `lib/features/settings/presentation/screens/settings_screen.dart`

Copier les repositories :
- [ ] Créer `lib/features/quran/data/repositories/`
- [ ] Copier `features_quran_quran_repository.dart` → `lib/features/quran/data/repositories/quran_repository.dart`
- [ ] Créer `lib/features/hadith/data/repositories/`
- [ ] Copier `features_hadith_hadith_repository.dart` → `lib/features/hadith/data/repositories/hadith_repository.dart`
- [ ] Créer `lib/features/vocabulary/data/repositories/`
- [ ] Copier `features_vocabulary_repository.dart` → `lib/features/vocabulary/data/repositories/vocabulary_repository.dart`

### Tests
- [ ] Créer `test/`
- [ ] Copier `test_app_test.dart` → `test/app_test.dart`

---

## 📥 PHASE 3 : Télécharger les Données (45 min)

### Créer la Structure Assets
```bash
mkdir -p assets/{quran,hadith,vocabulary,images,models,fonts}
```

- [ ] Dossier `assets/quran/` créé
- [ ] Dossier `assets/hadith/` créé
- [ ] Dossier `assets/vocabulary/` créé

### Télécharger Coran (ESSENTIEL)

**Fichier** : `quran-uthmani.json` (~5 MB)

**URL** :
```
https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/quran-uthmani.json
```

```bash
# Linux/Mac
curl -o assets/quran/quran-uthmani.json \
  https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/quran-uthmani.json

# Windows (PowerShell)
Invoke-WebRequest -Uri "https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/quran-uthmani.json" `
  -OutFile "assets\quran\quran-uthmani.json"
```

- [ ] Fichier `assets/quran/quran-uthmani.json` téléchargé
- [ ] Vérifier taille : `~5 MB`
- [ ] Vérifier contenu : `head assets/quran/quran-uthmani.json` → Doit montrer JSON valide

### Créer Vocabulaire (ESSENTIEL)

**Fichier** : `vocabulary.json` (à créer)

Créer `assets/vocabulary/vocabulary.json` avec au minimum :

```json
{
  "vocabulary_sets": [
    {
      "category": "Alphabet",
      "level": "beginner",
      "words": [
        {
          "arabic": "ا",
          "transliteration": "alif",
          "english": "Alef",
          "french": "Alef"
        }
      ]
    }
  ]
}
```

- [ ] Fichier `assets/vocabulary/vocabulary.json` créé
- [ ] Format JSON valide (utiliser https://jsonlint.com/ pour vérifier)

### Créer Alphabet (ESSENTIEL)

**Fichier** : `alphabet.json` (à créer)

Créer `assets/vocabulary/alphabet.json` avec les 28 lettres arabes.

- [ ] Fichier `assets/vocabulary/alphabet.json` créé
- [ ] Contient 28 lettres

### Télécharger Hadith (OPTIONNEL)

**Fichier** : `abu-dawud.json` (~10 MB)

```bash
curl -o assets/hadith/abu-dawud.json \
  https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/eng-abudawud.json
```

- [ ] Au minimum Abu Dawud téléchargé (optionnel)

### Télécharger Modèle IA (OPTIONNEL)

**Fichier** : `tinyllama-1.1b-q4.gguf` (~400 MB)

- [ ] Modèle TinyLLaMA téléchargé (optionnel)
- [ ] Placé dans `assets/models/`

---

## ⚙️ PHASE 4 : Configuration (10 min)

### pubspec.yaml Assets
Vérifier que `pubspec.yaml` contient :

```yaml
flutter:
  assets:
    - assets/quran/
    - assets/hadith/
    - assets/vocabulary/
    - assets/images/
    - assets/models/
    - assets/fonts/
```

- [ ] Assets déclarés dans `pubspec.yaml`
- [ ] Exécuter : `flutter pub get`

### Android Configuration (Si nécessaire)
- [ ] `android/app/build.gradle` → minSdkVersion >= 21
- [ ] `android/app/build.gradle` → compileSdkVersion >= 33

### iOS Configuration (Si nécessaire)
- [ ] `ios/Podfile` → platform :ios, '11.0' ou plus
- [ ] Exécuter : `cd ios && pod install && cd ..`

---

## 🧪 PHASE 5 : Tests (15 min)

### Build Check
- [ ] Compiler pour debug : `flutter build --debug`
- [ ] Pas d'erreurs de compilation
- [ ] Pas d'avertissements critiques

### Test Unitaires
- [ ] Exécuter : `flutter test`
- [ ] Tests doivent passer : `✓ AYA CLAUDE - Tests d'Intégrité`

### Vérifier les Fichiers
```bash
# Vérifier la structure
find lib -name "*.dart" | wc -l  # Doit être > 20

# Vérifier les assets
ls -lah assets/
ls -lah assets/quran/quran-uthmani.json
ls -lah assets/vocabulary/vocabulary.json

# Vérifier pubspec.yaml
head -50 pubspec.yaml
```

- [ ] 20+ fichiers Dart créés
- [ ] Assets présents
- [ ] pubspec.yaml valide

---

## 🚀 PHASE 6 : Exécution (5 min)

### Lancer l'App
```bash
# Option 1: Émulateur par défaut
flutter run

# Option 2: Appareil spécifique
flutter run -d <device_id>

# Option 3: Mode verbose (pour debug)
flutter run -v
```

- [ ] App démarre sans erreur
- [ ] Splash screen s'affiche (3 sec)
- [ ] Dashboard s'affiche après

### Vérifier Fonctionnalités
- [ ] Splash Screen s'affiche
- [ ] Dashboard charge avec 4 modules
- [ ] Tap "Lire le Coran" → Liste Sourates (5+ surahs)
- [ ] Tap une sourate → Détail sourate avec versets
- [ ] Tap "Apprendre l'Arabe" → Alphabet tab fonctionne
- [ ] Tap "Tuteur IA" → Chat interface marche
- [ ] Tap "Hadith" → Liste collections s'affiche
- [ ] Tap ⚙️ Settings → Settings screen s'affiche
- [ ] Navigation fonctionne (back button)

---

## 📱 PHASE 7 : Build Release (20 min)

### Android Release
```bash
# Build APK
flutter build apk --release

# Ou App Bundle (pour Play Store)
flutter build appbundle --release

# Vérifier
ls -lah build/app/outputs/
```

- [ ] APK créé : `build/app/outputs/flutter-app-release.apk`
- [ ] Taille < 200 MB
- [ ] Peut être installé sur téléphone

### iOS Release
```bash
flutter build ios --release

# Archive & deploy via Xcode
open ios/Runner.xcworkspace
```

- [ ] Archive créé
- [ ] Peut être soumis à TestFlight

### Web Release
```bash
flutter build web --release

# Fichiers dans build/web/
ls -lah build/web/
```

- [ ] Fichiers web générés
- [ ] Peut être déployé sur Firebase Hosting

---

## ☁️ PHASE 8 : Déploiement (Optionnel - 30 min)

### Firebase Hosting (Web)
```bash
# Installer Firebase CLI
npm install -g firebase-tools

# Login
firebase login

# Deploy
firebase deploy --only hosting
```

- [ ] Firebase CLI installé
- [ ] Connexion Firebase réussie
- [ ] Site web en live

### Google Play Store (Android)
- [ ] Créer compte développeur ($25 one-time)
- [ ] Signer l'APK avec clé
- [ ] Uploader sur Play Console
- [ ] Remplir store listing
- [ ] Soumettre pour review

### App Store (iOS)
- [ ] Compte développeur Apple ($99/an)
- [ ] Certificats provisioning
- [ ] TestFlight review
- [ ] App Store review
- [ ] Publier

---

## 📊 PHASE 9 : Monitoring & Maintenance

### Analytics
- [ ] Firebase Analytics configuré (optionnel)
- [ ] Voir les utilisateurs actifs
- [ ] Tracker les erreurs (Crashlytics)

### Updates
- [ ] Vérifier mises à jour Flutter : `flutter upgrade`
- [ ] Vérifier mises à jour packages : `flutter pub upgrade`
- [ ] Tester avant deployer

### Bugfix
- [ ] Logs : `flutter run --verbose`
- [ ] Debug: `flutter attach`
- [ ] Troubleshooting: Voir README.md

---

## 📚 Documentation Fournie

Consultez ces fichiers pour plus de détails :

- [ ] **README.md** - Vue d'ensemble complète
- [ ] **QUICKSTART.md** - Setup en 30 minutes
- [ ] **FILES_INDEX.md** - Index de tous les fichiers
- [ ] **SETUP_DATA.md** - Télécharger les données
- [ ] **AYA_CLAUDE_ARCHITECTURE.md** - Architecture technique
- [ ] **AYA_CLAUDE_CONTENT_AUDIT.md** - Sources & APIs
- [ ] **AYA_CLAUDE_IMPLEMENTATION_PLAN.md** - Plan détaillé
- [ ] **AYA_CLAUDE_EXECUTIVE_SUMMARY.md** - Résumé projet

---

## 🎯 RÉSUMÉ PAR ÉTAPE

| Phase | Durée | Tâches | ✓ |
|-------|-------|--------|---|
| 1. Setup | 30 min | Flutter, Dart, Éditeur | |
| 2. Copier | 20 min | 30 fichiers Dart | |
| 3. Données | 45 min | JSON + Assets | |
| 4. Config | 10 min | pubspec + paths | |
| 5. Tests | 15 min | Compilation + Tests | |
| 6. Exécution | 5 min | flutter run | |
| 7. Release | 20 min | Build APK/iOS/Web | |
| **TOTAL** | **2-3 heures** | **Production Ready** | |

---

## 🆘 SOS - Erreurs Courantes

### "File not found"
```bash
flutter clean
flutter pub get
flutter run
```

### "Cannot find SDK"
- Ajouter Flutter au PATH
- `flutter doctor` pour vérifier

### "Assets not loading"
- Vérifier pubspec.yaml
- `flutter pub get`
- Chemins corrects (case-sensitive!)

### "JSON decode error"
- Valider JSON : https://jsonlint.com/
- Vérifier fichier complet
- Pas de caractères invisibles

---

## 🎉 FÉLICITATIONS!

Une fois cette checklist terminée, vous aurez :

✅ Application Flutter complète  
✅ 114 Sourates du Coran  
✅ Module apprentissage Arabe  
✅ Tuteur IA interactif  
✅ Hadith + Settings  
✅ Tests unitaires  
✅ Prête pour Production  

---

**Prof AYA la Queen - READY TO DEPLOY! 🚀**

*Signature: Final Checklist v1.0*  
*Date: 27 Mars 2026*
