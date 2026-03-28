import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  static DatabaseService get instance => _instance;

  static const String _dbName = 'aya_claude.db';
  static const int _dbVersion = 1;

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createTables(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle migrations here
  }

  Future<void> _createTables(Database db) async {
    // ============== QURAN TABLES ==============
    await db.execute('''
      CREATE TABLE IF NOT EXISTS quran_surahs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        number INTEGER UNIQUE NOT NULL,
        name_arabic TEXT NOT NULL,
        name_transliteration TEXT,
        name_english TEXT,
        revelation_type TEXT,
        verse_count INTEGER,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
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
        FOREIGN KEY(surah_id) REFERENCES quran_surahs(id) ON DELETE CASCADE
      )
    ''');

    // ============== HADITH TABLES ==============
    await db.execute('''
      CREATE TABLE IF NOT EXISTS hadith_collections (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL,
        author TEXT,
        total_hadiths INTEGER,
        description TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS hadiths (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        collection_id INTEGER NOT NULL,
        hadith_number INTEGER NOT NULL,
        chapter TEXT,
        arabic_text TEXT NOT NULL,
        english_translation TEXT,
        french_translation TEXT,
        grade TEXT,
        narrator TEXT,
        UNIQUE(collection_id, hadith_number),
        FOREIGN KEY(collection_id) REFERENCES hadith_collections(id) ON DELETE CASCADE
      )
    ''');

    // ============== VOCABULARY TABLES ==============
    await db.execute('''
      CREATE TABLE IF NOT EXISTS vocabulary_sets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT NOT NULL,
        level TEXT NOT NULL,
        description TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        UNIQUE(category, level)
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS vocabulary_words (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        set_id INTEGER NOT NULL,
        arabic_word TEXT NOT NULL,
        transliteration TEXT,
        english TEXT,
        french TEXT,
        example_arabic TEXT,
        example_english TEXT,
        audio_url TEXT,
        FOREIGN KEY(set_id) REFERENCES vocabulary_sets(id) ON DELETE CASCADE
      )
    ''');

    // ============== ALPHABET TABLES ==============
    await db.execute('''
      CREATE TABLE IF NOT EXISTS alphabet_letters (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        letter_number INTEGER UNIQUE NOT NULL,
        arabic_letter TEXT UNIQUE NOT NULL,
        transliteration TEXT,
        english_name TEXT,
        french_name TEXT,
        audio_url TEXT,
        example_word TEXT,
        example_meaning TEXT,
        isolated_form TEXT,
        initial_form TEXT,
        medial_form TEXT,
        final_form TEXT
      )
    ''');

    // ============== USER PROGRESS TABLES ==============
    await db.execute('''
      CREATE TABLE IF NOT EXISTS user_progress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        module TEXT NOT NULL,
        lesson_id TEXT NOT NULL,
        completion_percentage REAL DEFAULT 0,
        score INTEGER DEFAULT 0,
        last_accessed DATETIME,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        UNIQUE(user_id, module, lesson_id)
      )
    ''');

    // ============== BOOKMARKS TABLES ==============
    await db.execute('''
      CREATE TABLE IF NOT EXISTS bookmarks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        content_type TEXT NOT NULL,
        content_id TEXT NOT NULL,
        title TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        UNIQUE(user_id, content_type, content_id)
      )
    ''');

    // ============== QUIZ TABLES ==============
    await db.execute('''
      CREATE TABLE IF NOT EXISTS user_quizzes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT NOT NULL,
        quiz_id TEXT NOT NULL,
        topic TEXT,
        answers_given TEXT,
        correct_answers INTEGER DEFAULT 0,
        total_questions INTEGER DEFAULT 0,
        score REAL DEFAULT 0,
        completed_at DATETIME,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // Create indices for performance
    await db.execute('CREATE INDEX IF NOT EXISTS idx_surah_id ON quran_verses(surah_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_user_progress ON user_progress(user_id, module)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_bookmarks ON bookmarks(user_id, content_type)');
  }

  // ============== QUERY HELPERS ==============

  Future<List<Map<String, dynamic>>> getSurahs() async {
    final db = await database;
    return await db.query('quran_surahs', orderBy: 'number');
  }

  Future<Map<String, dynamic>?> getSurah(int surahId) async {
    final db = await database;
    final result = await db.query(
      'quran_surahs',
      where: 'id = ?',
      whereArgs: [surahId],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getVerses(int surahId) async {
    final db = await database;
    return await db.query(
      'quran_verses',
      where: 'surah_id = ?',
      whereArgs: [surahId],
      orderBy: 'verse_number',
    );
  }

  Future<int> insertSurah(Map<String, dynamic> surah) async {
    final db = await database;
    return await db.insert('quran_surahs', surah, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> insertVerse(Map<String, dynamic> verse) async {
    final db = await database;
    return await db.insert('quran_verses', verse, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> insertHadith(Map<String, dynamic> hadith) async {
    final db = await database;
    return await db.insert('hadiths', hadith, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> insertVocabularyWord(Map<String, dynamic> word) async {
    final db = await database;
    return await db.insert('vocabulary_words', word);
  }

  Future<List<Map<String, dynamic>>> searchVerses(String query) async {
    final db = await database;
    return await db.query(
      'quran_verses',
      where: 'arabic_text LIKE ? OR french_translation LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
