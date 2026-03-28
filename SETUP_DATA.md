# 📥 Guide : Télécharger et Configurer les Données

**Comment obtenir les vraies données pour Prof AYA la Queen**

---

## 📖 1. CORAN - Données Complètes

### Fichier Principal : `quran-uthmani.json`

**URL** : 
```
https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/quran-uthmani.json
```

**Taille** : ~5 MB (Othmani - Texte arabe pur)

**Étapes** :

1. Télécharger le fichier JSON
2. Placer dans : `flutter_app/assets/quran/quran-uthmani.json`

```bash
# Linux/Mac
mkdir -p assets/quran
curl -o assets/quran/quran-uthmani.json \
  https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/quran-uthmani.json

# Windows (PowerShell)
mkdir -p assets\quran
Invoke-WebRequest -Uri "https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/quran-uthmani.json" `
  -OutFile "assets\quran\quran-uthmani.json"
```

### Traductions Français (Optionnel)

**URL Hamidullah** :
```
https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/fra-hamidullah.json
```

**Taille** : ~4 MB

```bash
# Télécharger
curl -o assets/quran/quran-fr-hamidullah.json \
  https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/fra-hamidullah.json
```

### Structure JSON Attendue

```json
{
  "surahs": [
    {
      "number": 1,
      "name": "الفاتحة",
      "englishName": "Al-Fatiha",
      "englishNameTranslation": "The Opening",
      "numberOfAyahs": 7,
      "revelationType": "Meccan",
      "ayahs": [
        {
          "number": 1,
          "text": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
          "numberInSurah": 1
        }
        // ... plus de versets
      ]
    }
    // ... 113 autres sourates
  ]
}
```

**Vérification** : Chaque sourate doit avoir entre 3-286 versets.

---

## 🕌 2. HADITH - Collections

### Collections Principales

**URL de Base** : `https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/`

Les 6 collections principales :

```
1. eng-abudawud.json (Abu Dawud - 5274 hadiths)
2. eng-bukhari.json (Bukhari - 7563 hadiths) 
3. eng-muslim.json (Muslim - 5852 hadiths)
4. eng-tirmidhi.json (Tirmidhi - 3956 hadiths)
5. eng-nasai.json (Nasai - 5761 hadiths)
6. eng-ibnmajah.json (Ibn Majah - 4344 hadiths)
```

**Télécharger (au minimum Abu Dawud)** :

```bash
mkdir -p assets/hadith

# Abu Dawud
curl -o assets/hadith/abu-dawud.json \
  https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/eng-abudawud.json

# Optionnel : Autres collections
curl -o assets/hadith/bukhari.json \
  https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/eng-bukhari.json
```

**Taille totale** : ~30-50 MB pour toutes les 6 collections

### Structure JSON Attendue

```json
{
  "hadiths": [
    {
      "number": 1,
      "text": "The hadith text...",
      "chapter": "Chapter Name",
      "status": "Sahih",
      "narrator": "Name of narrator"
    }
    // ... plus de hadiths
  ]
}
```

---

## 🔤 3. VOCABULAIRE ARABE

### Créer le fichier `vocabulary.json`

Vous devez créer ce fichier car il n'existe pas online.

**Emplacement** : `assets/vocabulary/vocabulary.json`

**Template** :

```json
{
  "vocabulary_sets": [
    {
      "id": "alphabet_001",
      "category": "Alphabet",
      "level": "beginner",
      "description": "Les 28 lettres de l'alphabet arabe",
      "words": [
        {
          "id": "alef",
          "arabic": "ا",
          "transliteration": "alif",
          "english": "Alef",
          "french": "Alef",
          "example": "أسد",
          "example_meaning": "Lion",
          "audio_url": ""
        }
        // ... 27 autres lettres
      ]
    },
    {
      "id": "family_001",
      "category": "Family",
      "level": "beginner",
      "words": [
        {
          "arabic": "أب",
          "transliteration": "ab",
          "english": "Father",
          "french": "Père",
          "example": "أبي",
          "example_meaning": "My father"
        }
        // ... plus de mots
      ]
    }
  ]
}
```

**Catégories suggérées** :
- Alphabet (28 lettres)
- Family (10-20 mots)
- Food (15-20 mots)
- Numbers (1-100)
- Verbs (20-30 verbes courants)
- Adjectives (15-20)
- Body Parts (15-20)
- House (10-15)

**Total suggéré** : 200-300 mots

### Créer le fichier `alphabet.json`

```json
{
  "alphabet": [
    {
      "number": 1,
      "letter": "ا",
      "transliteration": "alif",
      "english_name": "Alef",
      "french_name": "Alef",
      "example_word": "أسد",
      "example_meaning": "Lion",
      "isolated_form": "ا",
      "initial_form": "ا",
      "medial_form": "ـا",
      "final_form": "ـا"
    }
    // ... 27 autres lettres
  ]
}
```

---

## 🧠 4. MODÈLE IA (TinyLLaMA)

### Télécharger TinyLLaMA

**URL** :
```
https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF
```

**Fichier Recommandé** :
```
tinyllama-1.1b-chat-v1.0.Q4_K_M.gguf
```

**Taille** : ~400 MB

**Étapes** :

1. Aller sur https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF
2. Télécharger le fichier `.gguf`
3. Placer dans : `flutter_app/assets/models/tinyllama-1.1b-q4.gguf`

```bash
# Avec git-lfs (si installé)
git clone https://huggingface.co/TheBloke/TinyLlama-1.1B-Chat-v1.0-GGUF
cp TinyLlama-1.1B-Chat-v1.0-GGUF/*.gguf assets/models/

# Sinon télécharger manuellement via le navigateur
```

**⚠️ IMPORTANT** : 
- Le fichier est lourd (~400 MB)
- Peut prendre 10-30 min à télécharger
- Optionnel pour démarrage (app fonctionne sans)

---

## 📁 Structure Finale

```
flutter_app/
├── assets/
│   ├── quran/
│   │   ├── quran-uthmani.json ✅ ESSENTIEL
│   │   └── quran-fr-hamidullah.json (optionnel)
│   ├── hadith/
│   │   ├── abu-dawud.json ✅ AU MINIMUM
│   │   ├── bukhari.json (optionnel)
│   │   ├── muslim.json (optionnel)
│   │   └── ... (autres collections)
│   ├── vocabulary/
│   │   ├── vocabulary.json ✅ À CRÉER
│   │   └── alphabet.json ✅ À CRÉER
│   ├── models/
│   │   └── tinyllama-1.1b-q4.gguf (optionnel)
│   └── images/
│       └── (images pour UI)
├── lib/
│   └── ... (code Flutter)
└── pubspec.yaml
```

---

## 🚀 Initialisation Automatique

L'app charge automatiquement les données au démarrage via `AppInitializer` :

```dart
// Dans main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialiser et charger les données
  await AppInitializer().initialize();
  
  runApp(const ProviderScope(child: AyaClaudeApp()));
}
```

**Comportement** :
- ✅ Vérifie si données déjà chargées
- ✅ Charge Coran en DB (si JSON trouvé)
- ✅ Charge Hadith en DB (si JSON trouvé)
- ✅ Charge Vocabulaire en DB (si JSON trouvé)
- ✅ Affiche statistiques chargées
- ⚠️ Continue même si certaines données manquent

---

## ⚡ DÉMARRAGE RAPIDE (Minimum Viable)

**Minimum requis pour que l'app fonctionne** :

1. ✅ `assets/quran/quran-uthmani.json`
2. ✅ `assets/vocabulary/vocabulary.json` (créer)

**Tout le reste est optionnel pour MVP**.

```bash
# Télécharger le minimum
mkdir -p assets/{quran,vocabulary}

# Coran
curl -o assets/quran/quran-uthmani.json \
  https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/quran-uthmani.json

# Créer vocabulaire.json manuellement (voir template)
echo '{your json here}' > assets/vocabulary/vocabulary.json

# Lancer
flutter pub get
flutter run
```

---

## ✅ CHECKLIST DONNÉES

```
✅ Coran
  □ quran-uthmani.json (ESSENTIEL)
  □ quran-fr-hamidullah.json (optionnel)

✅ Hadith
  □ Abu Dawud JSON (optionnel)
  □ Collections restantes (optionnel)

✅ Vocabulaire
  □ vocabulary.json créé (ESSENTIEL)
  □ alphabet.json créé (ESSENTIEL)

✅ Modèle IA
  □ tinyllama-1.1b-q4.gguf (optionnel)

✅ Images/Assets
  □ Logo/Icons (optionnel)
  □ Splashscreen image (optionnel)
```

---

## 🔍 Vérification

Après avoir téléchargé les données :

```bash
# Vérifier les fichiers
ls -lah assets/quran/
ls -lah assets/hadith/
ls -lah assets/vocabulary/

# Vérifier tailles
du -sh assets/

# Vérifier contenu JSON
head -20 assets/quran/quran-uthmani.json
```

**Résultat attendu** :
```
assets/quran/quran-uthmani.json        ~5 MB
assets/vocabulary/vocabulary.json      ~50-100 KB
assets/hadith/*.json                   (si téléchargé)
assets/models/tinyllama-*.gguf         ~400 MB (si téléchargé)
```

---

## 🆘 Troubleshooting

### ❌ "Error: assets/quran/quran-uthmani.json not found"

**Solution** :
```bash
# S'assurer que flutter_app/ contient le dossier assets/
ls -la flutter_app/assets/

# Si manquant, créer
mkdir -p flutter_app/assets/quran
mkdir -p flutter_app/assets/vocabulary

# Puis télécharger les fichiers
```

### ❌ "JSON decode error"

**Solution** :
- Vérifier que le JSON est valide
- Utiliser un validateur JSON : https://jsonlint.com/
- S'assurer que le fichier est complet (terminé par `}`)

### ❌ "Asset not declared in pubspec.yaml"

**Solution** :
```yaml
# Dans pubspec.yaml, s'assurer que vous avez:
flutter:
  assets:
    - assets/quran/
    - assets/hadith/
    - assets/vocabulary/
    - assets/models/
    - assets/images/
```

Puis exécuter :
```bash
flutter pub get
flutter clean
flutter run
```

---

**Fin du guide de configuration des données ✅**

*Prof AYA la Queen - Ready for Data 📚*
