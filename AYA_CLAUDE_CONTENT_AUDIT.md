# 📚 AYA CLAUDE : Audit Complet & Sourcing du Contenu
**Version 2026 | Plateforme : Flutter (iOS/Android) + Web | IA Offline : TinyLLaMA 1.1B**

---

## 🎯 Résumé Exécutif

L'application **Prof AYA la Queen** est une plateforme d'apprentissage intégrée pour l'**Arabe** + **Sciences Islamiques** + **Coran**. Tous les contenus ci-dessous sont **100% gratuits, open-source et légalement utilisables** avec respect des licenses.

---

# 📖 PARTIE 1 : SOURCES CORAN

## ✅ API Coran Recommandées (Classées par Priorité)

### 🏆 **1. Quran API (fawazahmed0) - MEILLEUR CHOIX**
**URL** : https://github.com/fawazahmed0/quran-api  
**CDN** : https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/

| Aspect | Détail |
|--------|--------|
| **Format** | JSON complet (texte + traductions + audio) |
| **Traductions** | 90+ langues, 400+ traductions |
| **Arabe** | Texte Othmani ✅ |
| **Français** | Hamidullah ✅ |
| **Audio** | Multiple récitations (Mishary Alafasy, etc.) |
| **Licence** | Open Source ✅ |
| **Sans limite** | ✅ Pas de rate limit |
| **Pour offline** | Téléchargement JSON complet possible |

**Endpoints utiles** :
```
# Récupérer Coran complet (Othmani)
https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/quran-uthmani.json

# Sourate + Traduction Hamidullah
https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/fra-hamidullah/5.json

# Verset spécifique (Sourate 5, Verset 10)
https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions/fra-hamidullah/5/10.json

# Infos Coran (Juz, Rukus, Sajdas)
https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/info.json

# Listes toutes éditions disponibles
https://cdn.jsdelivr.net/gh/fawazahmed0/quran-api@1/editions.json
```

---

### 2. **Al-Quran API**
**URL** : https://alquran-api.pages.dev/  
**Avantage** : Recherche intégrée, Edge Runtime rapide  

```
# Exemple requête
https://alquran-api.pages.dev/api/quran/surah/1?lang=en
```

---

### 3. **Quran Cloud API**
**URL** : http://api.alquran.cloud/v1/  
**Avantages** : Différentes éditions (Uthmani, translitération, traductions)

```
# Coran complet (Othmani)
http://api.alquran.cloud/v1/quran/quran-uthmani

# Avec traduction anglaise
http://api.alquran.cloud/v1/quran/en.asad

# Audio Mishary Alafasy
http://api.alquran.cloud/v1/quran/ar.alafasy
```

---

### 4. **Risan Quran JSON**
**URL** : https://github.com/risan/quran-json  
**CDN** : https://cdn.jsdelivr.net/npm/quran-json@3.1.2/

```
# Coran + Translitération
https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/quran_transliteration.json

# Traduction Française (Hamidullah)
https://cdn.jsdelivr.net/npm/quran-json@3.1.2/dist/quran_fr.json
```

---

## 📥 **Stratégie Offline pour Coran**

```
Structure SQLite locale :
┌─────────────────────────────────────────┐
│ TABLE: quran_verses                     │
├─────────────────────────────────────────┤
│ id (PK)                                 │
│ surah_id                                │
│ verse_number                            │
│ arabic_text (Othmani)                   │
│ french_translation (Hamidullah)         │
│ english_translation                     │
│ audio_url (Alafasy)                     │
│ transliteration                         │
└─────────────────────────────────────────┘

TABLE: quran_surahs
├─────────────────────────────────────────┤
│ id (PK)                                 │
│ number                                  │
│ name_arabic                             │
│ name_french                             │
│ revelation_type (Meccan/Medinan)        │
│ verse_count                             │
│ meaning                                 │
└─────────────────────────────────────────┘
```

---

# 🕌 PARTIE 2 : HADITH & SUNNAH

## ✅ API Hadith Recommandées

### 🏆 **1. Fawazahmed0 Hadith API - MEILLEUR CHOIX**
**URL** : https://github.com/fawazahmed0/hadith-api  
**CDN** : https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/

| Aspect | Détail |
|--------|--------|
| **Collections** | 6+ collections (Bukhari, Muslim, Abu Dawud, etc.) |
| **Hadiths** | 50,000+ hadiths |
| **Langues** | Arabe + Anglais + Autres |
| **Licence** | Open Source ✅ |
| **Sans limite** | ✅ Pas de rate limit |
| **Offline** | Téléchargement JSON possible |
| **Notation** | Grades (Sahih, Hasan, Da'if) |

**Endpoints** :
```
# Lister toutes éditions
https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions.json

# Collection Bukhari (Anglais)
https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/eng-abudawud.json

# Hadith spécifique (ID 1035)
https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/eng-abudawud/1035.json

# Section 7
https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/eng-abudawud/sections/7.json

# Infos complètes (grades, références)
https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/info.json
```

---

### 2. **HadeethEnc.com**
**URL** : https://hadeethenc.com  
**API** : https://documenter.getpostman.com/view/5211979/TVev3j7q  
**Avantage** : Explications simplifiées + traductions  

---

### 3. **Hadith JSON Dataset**
**URL** : https://github.com/AhmedBaset/hadith-json  
**Avantage** : 50,884 hadiths en JSON + CSV

---

### 4. **Sunnah.com API**
**URL** : https://sunnah.com/developers  
**Note** : Nécessite clé API (gratuite à demander)

---

## 📥 **Stratégie Offline pour Hadith**

```
TABLE: hadiths
├─────────────────────────────────────────┤
│ id (PK)                                 │
│ collection_id (Bukhari, Muslim, etc)   │
│ hadith_number                           │
│ arabic_text                             │
│ english_translation                     │
│ french_translation                      │
│ grade (Sahih, Hasan, Da'if)            │
│ chapter_id                              │
│ narrator_chain                          │
│ reference_link                          │
└─────────────────────────────────────────┘
```

---

# 📚 PARTIE 3 : CONTENU PÉDAGOGIQUE ARABE

## ✅ Ressources d'Apprentissage (Structures à Créer)

### **Module 1 : Alphabet Arabe (Abjad)**

**Structure de base** :
```json
{
  "alphabet": [
    {
      "id": 1,
      "name_ar": "ا",
      "name_en": "Alef",
      "name_phonetic": "alif",
      "audio_url": "https://cdn...alef.mp3",
      "forms": {
        "isolated": "ا",
        "initial": "ا",
        "medial": "ـا",
        "final": "ـا"
      },
      "example_word": "أَسَد",
      "example_meaning": "Lion"
    }
    // ... 28 lettres
  ]
}
```

**Sources recommandées** :
- Open University "Introduction to Arabic" - Alphabet lessons avec audio
- Arabic Reading Course - Cours alphabet + practice
- Learn Arabic Online - Ressources complètes classiques

---

### **Module 2 : Vocabulaire Thématique**

**Catégories** :
```
├── Famille (père, mère, frère, sœur...)
├── Aliments (pain, eau, viande, fruits...)
├── Jours & Mois
├── Nombres (0-100 + millions)
├── Verbes courants (aller, venir, manger, boire...)
├── Adjectifs (grand, petit, beau, bon...)
├── Corps humain (tête, main, pied, œil...)
├── Maison & Meubles
├── Vêtements
└── Sciences Islamiques (Coran, Sunnah, Salat...)
```

**Format JSON** :
```json
{
  "vocabulary_sets": [
    {
      "id": "family_001",
      "category": "Family",
      "level": "beginner",
      "words": [
        {
          "id": "w_001",
          "arabic": "أب",
          "transliteration": "ab",
          "english": "father",
          "french": "père",
          "audio_url": "https://cdn...ab.mp3",
          "example": "هذا أبي",
          "example_meaning": "This is my father"
        }
      ]
    }
  ]
}
```

---

### **Module 3 : Grammaire (Nahw)**

**Structures de base** :
- Présent simple (فِعْل مَاضِي / فِعْل مُضَارِع)
- Nominatif, Accusatif, Génitif (الرَّفْع, النَّصْب, الجَرّ)
- Genre féminin/masculin
- Pluriel (سَالِم, كَسْر)
- Verbes réguliers vs irréguliers

**Source** : Learn Arabic Online propose des tutoriels complets sur morphologie, syntaxe et grammaire

---

# 🧠 PARTIE 4 : INTÉGRATION IA

## ✅ **Modèle IA Recommandé : TinyLLaMA 1.1B**

### **Caractéristiques**
- ✅ **Taille** : 637 MB (téléchargeable en assets)
- ✅ **Format** : GGML quantisé (int4 = 200-400 MB)
- ✅ **Latence** : 50-100ms/token sur téléphone récent
- ✅ **RAM** : 2-3 GB suffisant
- ✅ **Coût** : 0€
- ✅ **Offline** : 100% local

### **Cas d'usage dans l'app**
1. **Tuteur IA** : Répondre questions Arabe/Coran
2. **Quiz intelligent** : Générer questions adaptatives
3. **Correction** : Évaluer réponses utilisateur
4. **Explications** : Clarifier grammaire/sens versets

### **Prompts pédagogiques optimisés**

```
PROMPT 1 : Enseignant Arabe
---
Role: You are an expert Arabic teacher specializing in beginner-level MSA (Modern Standard Arabic).

User level: [Beginner/Intermediate/Advanced]
Topic: [Alphabet/Vocabulary/Grammar/Quran]

Provide:
1. Clear explanation (2-3 sentences max)
2. Practical example
3. One practice question

Language: Use simple, encouraging tone.
---

PROMPT 2 : Quiz Adaptatif
---
Generate a quiz question about [TOPIC] at [LEVEL] difficulty.
Format: 
- Question (Arabic + English translation)
- 4 multiple choice answers
- Correct answer + explanation
- Score points if correct

Previous score: [USER_SCORE]
Adjust difficulty accordingly.
---

PROMPT 3 : Correction Coran
---
User answered: "[USER_ANSWER]"
About Ayah: [SURAH:AYAH]
Quran text: "[AYAH_TEXT]"

Evaluate the user's answer:
1. Correctness (% score)
2. Explanation of what they missed
3. Related Ayahs for deeper learning
---
```

---

## 🔗 **Backend IA : Ollama + Google Cloud**

### **Architecture**
```
┌─────────────────────────────────────┐
│   Flutter App (iOS/Android)          │
├─────────────────────────────────────┤
│  IA Requests (TinyLLaMA local)       │
│  + Sync with Backend                │
└──────────────┬──────────────────────┘
               │
        ┌──────▼───────┐
        │ Google Cloud │
        │ Free Tier    │
        └──────┬───────┘
               │
      ┌────────┴──────────┐
      │                   │
    ┌─▼──┐          ┌────▼────┐
    │Cloud│ ←→       │Firestore│
    │Func │ ←→       │ (Sync)   │
    │(IA) │          └─────────┘
    └────┘
```

### **Configuration Ollama (Docker)**

```dockerfile
FROM ollama/ollama:latest

# Télécharger modèle au build
RUN ollama serve & sleep 5 && ollama pull tinyllama:latest

EXPOSE 11434
```

**Deploy sur Google Cloud Run** :
- ✅ 180 minutes/jour gratuit
- ✅ Auto-scale à 0 quand inactif
- ✅ Coût : ~0€/mois usage léger

---

# 🗄️ PARTIE 5 : ARCHITECTURE BASE DE DONNÉES

## **SQLite Local + Firebase Sync**

### **Tables Principales**

```sql
-- Coran
CREATE TABLE quran_surahs (
  id INTEGER PRIMARY KEY,
  number INTEGER UNIQUE,
  name_arabic TEXT,
  name_transliteration TEXT,
  revelation_type TEXT,
  verse_count INTEGER
);

CREATE TABLE quran_verses (
  id INTEGER PRIMARY KEY,
  surah_id INTEGER FOREIGN KEY,
  verse_number INTEGER,
  arabic_text TEXT,
  french_translation TEXT,
  audio_url TEXT,
  UNIQUE(surah_id, verse_number)
);

-- Hadith
CREATE TABLE hadith_collections (
  id INTEGER PRIMARY KEY,
  name TEXT,
  author TEXT,
  total_hadiths INTEGER
);

CREATE TABLE hadiths (
  id INTEGER PRIMARY KEY,
  collection_id INTEGER FOREIGN KEY,
  hadith_number INTEGER,
  arabic_text TEXT,
  english_translation TEXT,
  grade TEXT,
  chapter TEXT
);

-- Vocabulaire
CREATE TABLE vocabulary (
  id INTEGER PRIMARY KEY,
  category TEXT,
  arabic_word TEXT,
  transliteration TEXT,
  english_translation TEXT,
  french_translation TEXT,
  audio_url TEXT,
  difficulty_level TEXT
);

-- Progression Utilisateur
CREATE TABLE user_progress (
  id INTEGER PRIMARY KEY,
  user_id TEXT FOREIGN KEY,
  module TEXT,
  lesson_id INTEGER,
  completion_percentage REAL,
  score INTEGER,
  last_accessed DATETIME,
  UNIQUE(user_id, module, lesson_id)
);

CREATE TABLE user_quizzes (
  id INTEGER PRIMARY KEY,
  user_id TEXT FOREIGN KEY,
  quiz_id TEXT,
  answers_given TEXT,
  score INTEGER,
  completed_at DATETIME
);

-- Marque-pages & Préférences
CREATE TABLE bookmarks (
  id INTEGER PRIMARY KEY,
  user_id TEXT FOREIGN KEY,
  content_type TEXT,
  content_id TEXT,
  created_at DATETIME
);
```

---

# 🔐 PARTIE 6 : FIREBASE CONFIGURATION

## **Services Gratuits à Utiliser**

| Service | Usage Gratuit | Pour AYA |
|---------|---|---|
| **Authentication** | 50K utilisateurs | Inscription/Connexion |
| **Firestore** | 1 GB stockage, 50K lectures/jour | Sync progression |
| **Hosting** | Illimité (100 MB/mois) | Site web + PWA |
| **Storage** | 5 GB | Médias offline |
| **Cloud Functions** | 2 millions appels/mois | Backend léger |
| **Analytics** | Gratuit | Tracking usage |

---

# ✅ RÉSUMÉ RÉCAPITULATIF

## **Checklist Contenu à Télécharger**

```
AYA_CLAUDE/assets/
├── quran/
│   ├── quran-uthmani.json (5-10 MB compressé)
│   ├── quran-fr-hamidullah.json
│   └── quran-audio-metadata.json
├── hadith/
│   ├── bukhari.json
│   ├── muslim.json
│   └── abudawud.json
├── vocabulary/
│   ├── alphabet.json (28 lettres)
│   ├── vocabulary-sets.json (2000+ mots)
│   └── grammar-rules.json
├── audio/
│   └── (téléchargements spécifiques demandés)
└── models/
    └── tinyllama-1.1b-q4.gguf (200-400 MB)
```

---

## **Sources Officielles Finales**

| Ressource | URL | Licence |
|-----------|-----|---------|
| **Coran API** | https://github.com/fawazahmed0/quran-api | MIT ✅ |
| **Hadith API** | https://github.com/fawazahmed0/hadith-api | MIT ✅ |
| **Hadith JSON** | https://github.com/AhmedBaset/hadith-json | MIT ✅ |
| **Sunnah Dataset** | https://huggingface.co/datasets/meeAtif/hadith_datasets | Open ✅ |
| **Learn Arabic** | https://learnarabiconline.com/ | Educational ✅ |
| **TinyLLaMA** | https://huggingface.co/TinyLlama/TinyLlama-1.1B | Apache 2.0 ✅ |
| **Ollama** | https://ollama.ai/ | MIT ✅ |

---

**Document créé pour AYA CLAUDE (Prof AYA la Queen v2026)**  
**Prêt pour Phase 3 : Implémentation Progressive**
