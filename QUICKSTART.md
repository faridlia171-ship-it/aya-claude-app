# ⚡ QUICKSTART - Prof AYA en 30 Minutes

**Suivez ces 5 étapes simples pour démarrer l'app!**

---

## ✅ Étape 1 : Vérifier les Prérequis (2 min)

```bash
# Vérifier Flutter
flutter --version
# Résultat attendu : Flutter 3.x.x

# Vérifier Dart
dart --version
# Résultat attendu : Dart 3.x.x
```

**Si vous n'avez pas Flutter** :
- Télécharger : https://flutter.dev/docs/get-started/install
- Installer selon votre OS (Windows/Mac/Linux)

---

## ✅ Étape 2 : Créer le Projet (5 min)

```bash
# 1. Créer nouveau projet Flutter
flutter create --org=com.ayaclaude flutter_app

# 2. Naviguer dedans
cd flutter_app

# 3. Nettoyer
flutter clean
flutter pub get
```

**Résultat** : Dossier `flutter_app/` créé avec structure standard.

---

## ✅ Étape 3 : Copier les Fichiers (10 min)

### Étape 3a : Télécharger les fichiers

Tous les fichiers sont dans `/mnt/user-data/outputs/`:

- `lib_main.dart` → `lib/main.dart`
- `pubspec.yaml` → `/pubspec.yaml` (remplacer)
- `core_*.dart` → `lib/core/*/`
- `config_*.dart` → `lib/config/`
- `features_*.dart` → `lib/features/*/screens/`

### Étape 3b : Structure finale

```
flutter_app/
├── lib/
│   ├── main.dart
│   ├── core/
│   │   ├── theme/app_theme.dart
│   │   ├── constants/app_strings.dart
│   │   ├── db/database_service.dart
│   │   └── services/
│   │       ├── ai_service.dart
│   │       └── logger_service.dart
│   ├── config/
│   │   ├── router.dart
│   │   └── dependency_injection.dart
│   └── features/
│       ├── splash/presentation/screens/splash_screen.dart
│       ├── dashboard/presentation/screens/dashboard_screen.dart
│       ├── quran/presentation/screens/
│       │   ├── quran_list_screen.dart
│       │   └── surah_detail_screen.dart
│       ├── arabic_learning/presentation/screens/learning_screen.dart
│       ├── ai_tutor/presentation/screens/ai_tutor_screen.dart
│       ├── hadith/presentation/screens/hadith_list_screen.dart
│       └── settings/presentation/screens/settings_screen.dart
├── pubspec.yaml (remplacé)
├── android/
├── ios/
└── web/
```

---

## ✅ Étape 4 : Installer les Dépendances (5 min)

```bash
# Depuis le dossier flutter_app/
flutter pub get

# Attendre que tout se télécharge...
# Devrait prendre 2-5 minutes la première fois
```

**Résultat** : Tous les packages installés ✅

---

## ✅ Étape 5 : Lancer l'App (3 min)

```bash
# Option A : Sur l'émulateur Android
flutter run

# Option B : Sur l'émulateur iOS
flutter run -d macos

# Option C : Sur un appareil connecté
flutter run

# Option D : En mode debug avec hot reload
flutter run --debug
```

**Attendez 10-30 secondes...**

---

## 🎉 Résultat Final

Vous devriez voir l'app démarrer avec :

```
1. Splash Screen (animation 3 sec)
   ↓
2. Dashboard Screen (Accueil)
   ├── 4 Module Cards
   │   ├── 🕌 Lire le Coran
   │   ├── 📚 Apprendre l'Arabe
   │   ├── 🧠 Tuteur IA
   │   └── 🤝 Hadith
   └── 3 Stats Cards
       ├── Versets Lus: 0
       ├── Leçons: 0
       └── Quiz: 0
```

**Cliquez sur les cards pour naviguer!**

---

## 🔧 Dépannage Express

### ❌ Erreur: "No connected devices"

```bash
# Solution 1: Créer émulateur
flutter emulators --create --name pixel4

# Solution 2: Lancer émulateur existant
flutter emulators --launch pixel4

# Solution 3: Brancher un appareil Android/iOS
# Puis relancer : flutter run
```

### ❌ Erreur: "pubspec.yaml not found"

```bash
# Vérifier que vous êtes dans le bon dossier
cd flutter_app
ls pubspec.yaml  # Devrait afficher le fichier
```

### ❌ Erreur: "Command 'flutter' not found"

```bash
# Flutter pas dans le PATH
# Ajouter au PATH :

# Windows (PowerShell) :
$env:PATH += ";C:\flutter\bin"

# Mac/Linux (.bashrc ou .zshrc) :
export PATH="$PATH:$HOME/flutter/bin"
```

### ❌ Erreur: "Build failed"

```bash
# Nettoyer et recommencer
flutter clean
flutter pub get
flutter run
```

---

## 🚀 Prochaines Étapes

### 1. Tester les Modules

- ✅ Tap "Lire le Coran" → Voir 5 Sourates
- ✅ Tap "Apprendre l'Arabe" → Voir Alphabet + Grammaire
- ✅ Tap "Tuteur IA" → Poser une question
- ✅ Tap "Hadith" → Voir Collections
- ✅ Tap ⚙️ en haut → Settings

### 2. Ajouter les Données

```bash
# Créer dossier assets
mkdir -p assets/{quran,hadith,vocabulary,models}

# Télécharger Coran JSON (5-10 MB)
# URL: https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/quran-uthmani.json
# → assets/quran/quran-uthmani.json

# Puis modifier database_service.dart pour charger les données réelles
# Au lieu des samples actuels
```

### 3. Activer Hot Reload

```bash
# L'app supporte hot reload par défaut
# Modifiez un fichier → Tapez 'r' dans le terminal
# L'app se recharge SANS redémarrer
```

---

## ✨ Astuces Pro

### 1. Debug Info

```bash
# Voir logs détaillés
flutter run --debug --verbose

# Voir FPS de l'app
flutter run --profile --device-startup-stage

# Voir mémoire/performance
flutter run --profile
```

### 2. Hot Reload Raccourcis

```
r  → Hot reload (rechargement chaud)
R  → Hot restart (restart complet)
q  → Quitter
p  → Toggle performance overlay
```

### 3. Tester sur Web

```bash
# Lancer sur Chrome
flutter run -d chrome

# Lancer sur Firefox
flutter run -d firefox

# Lancer sur edge
flutter run -d edge
```

---

## 📊 Checklist Finale

```
✅ Flutter installé (flutter --version)
✅ Projet créé (flutter create)
✅ Fichiers copiés (lib/, config/, features/)
✅ pubspec.yaml remplacé
✅ flutter pub get exécuté
✅ flutter run fonctionne
✅ App démarre sans erreurs
✅ Dashboard affiche 4 modules
✅ Navigation entre écrans marche
✅ Buttons sont cliquables
```

---

## 🎓 Étapes Suivantes (Si vous voulez avancer)

### Charger les Données Réelles

```dart
// Dans database_service.dart, modifier _createTables()
// pour charger JSON depuis assets/quran/quran-uthmani.json
await _loadQuranFromAssets();
```

### Intégrer TinyLLaMA

```dart
// Dans ai_service.dart, implémenter:
await _model.load('assets/models/tinyllama-1.1b-q4.gguf');
final response = await _model.generate(prompt: userPrompt);
```

### Ajouter Firebase (Optionnel)

```dart
// Dans config/dependency_injection.dart
await Firebase.initializeApp();
final auth = FirebaseAuth.instance;
```

---

## 📞 Besoin d'Aide?

Si vous êtes bloqué :

1. Relire ce guide (Étape par Étape)
2. Vérifier le README.md (détails)
3. Vérifier logs d'erreur (flutter run -v)
4. Nettoyer : `flutter clean && flutter pub get`
5. Redémarrer : Fermer terminal et recommencer

---

**Vous avez 30 minutes pour avoir une app fonctionnelle!** ⏰

Bonne chance! 🚀

*Prof AYA la Queen v2026 - Ready to Launch*
