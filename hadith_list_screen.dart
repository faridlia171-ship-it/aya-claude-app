import 'package:sqflite/sqflite.dart';
import 'core/db/database_service.dart';
import 'core/services/ai_service.dart';
import 'core/services/logger_service.dart';

/// Classe pour gérer l'initialisation complète de l'app
class AppInitializer {
  static final AppInitializer _instance = AppInitializer._internal();

  factory AppInitializer() => _instance;

  AppInitializer._internal();

  final logger = LoggerService();

  // État d'initialisation
  bool _isInitialized = false;
  bool _dataLoaded = false;

  bool get isInitialized => _isInitialized;
  bool get dataLoaded => _dataLoaded;

  /// Initialisation complète de l'app
  Future<void> initialize() async {
    if (_isInitialized) {
      logger.info('✅ App déjà initialisée');
      return;
    }

    try {
      logger.info('🚀 Démarrage de l\'initialisation...');

      // 1. Initialiser la base de données
      logger.info('📦 Initialisation de la base de données...');
      final db = await DatabaseService.instance.database;
      logger.info('✅ Base de données initialisée');

      // 2. Charger les données
      logger.info('📚 Chargement des données...');
      await _loadAppData(db);
      logger.info('✅ Données chargées avec succès');

      // 3. Initialiser les services
      logger.info('⚙️ Initialisation des services...');
      await _initializeServices();
      logger.info('✅ Services initialisés');

      _isInitialized = true;
      _dataLoaded = true;

      logger.info('🎉 Application prête!');
    } catch (e, stackTrace) {
      logger.error('❌ Erreur lors de l\'initialisation', e, stackTrace);
      rethrow;
    }
  }

  /// Charger toutes les données de l'app
  Future<void> _loadAppData(Database db) async {
    try {
      // Importer les repositories
      // ignore: avoid_relative_lib_imports
      final QuranRepository quranRepo = QuranRepository(database: db);
      // ignore: avoid_relative_lib_imports
      final HadithRepository hadithRepo = HadithRepository(database: db);
      // ignore: avoid_relative_lib_imports
      final VocabularyRepository vocabRepo = VocabularyRepository(database: db);

      // 1. Charger Coran
      logger.info('📖 Chargement du Coran...');
      try {
        await quranRepo.loadQuranFromAssets();
        await quranRepo.loadFrenchTranslations();
      } catch (e) {
        logger.warning('⚠️  Coran non chargé (assets manquants): $e');
      }

      // 2. Charger Hadith
      logger.info('📚 Chargement des Hadith...');
      try {
        await hadithRepo.loadHadithCollections();
        
        // Charger les collections individuelles
        final collections = ['Abu Dawud', 'At-Tirmidhi', 'An-Nasai'];
        for (var collection in collections) {
          try {
            await hadithRepo.loadHadithsFromAssets(collection);
          } catch (e) {
            logger.warning('⚠️  Collection $collection non trouvée: $e');
          }
        }
      } catch (e) {
        logger.warning('⚠️  Hadith non chargés (assets manquants): $e');
      }

      // 3. Charger Vocabulaire
      logger.info('🔤 Chargement du Vocabulaire...');
      try {
        await vocabRepo.loadVocabularyFromAssets();
        await vocabRepo.loadAlphabetFromAssets();
      } catch (e) {
        logger.warning('⚠️  Vocabulaire non chargé (assets manquants): $e');
      }

      // 4. Afficher les statistiques
      try {
        final quranStats = await db.rawQuery(
          'SELECT COUNT(*) as surahs FROM quran_surahs, COUNT(*) as verses FROM quran_verses',
        );
        final hadithStats = await hadithRepo.getCollectionStats();
        final vocabStats = await vocabRepo.getVocabularyStats();

        logger.info('''
📊 STATISTIQUES CHARGÉES:
   Coran: 114 Sourates, ${await _countVerses(db)} Versets
   Hadith: ${hadithStats['collections']} Collections, ${hadithStats['hadiths']} Hadiths
   Vocabulaire: ${vocabStats['vocabulary_sets']} Catégories, ${vocabStats['words']} Mots
   Alphabet: ${vocabStats['alphabet_letters']} Lettres
        ''');
      } catch (e) {
        logger.warning('⚠️  Impossible d\'afficher les statistiques: $e');
      }
    } catch (e, stackTrace) {
      logger.error('❌ Erreur lors du chargement des données', e, stackTrace);
      rethrow;
    }
  }

  /// Initialiser les services
  Future<void> _initializeServices() async {
    try {
      // Initialiser AI Service
      final aiService = AIService();
      await aiService.initialize();
      logger.info('✅ Service IA initialisé');
    } catch (e) {
      logger.warning('⚠️  Service IA non initialisé: $e');
    }
  }

  /// Utilitaire pour compter les versets
  Future<int> _countVerses(Database db) async {
    try {
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM quran_verses',
      );
      return (result.first['count'] as int);
    } catch (e) {
      logger.warning('⚠️  Impossible de compter les versets: $e');
      return 0;
    }
  }

  /// Réinitialiser l'app (pour dev/testing)
  Future<void> reset() async {
    try {
      logger.info('🔄 Réinitialisation de l\'app...');
      
      final db = await DatabaseService.instance.database;
      
      // Supprimer toutes les tables
      await db.execute('DELETE FROM quran_verses');
      await db.execute('DELETE FROM quran_surahs');
      await db.execute('DELETE FROM hadiths');
      await db.execute('DELETE FROM hadith_collections');
      await db.execute('DELETE FROM vocabulary_words');
      await db.execute('DELETE FROM vocabulary_sets');
      await db.execute('DELETE FROM alphabet_letters');
      await db.execute('DELETE FROM bookmarks');
      await db.execute('DELETE FROM user_progress');

      _dataLoaded = false;
      
      logger.info('✅ App réinitialisée');
    } catch (e, stackTrace) {
      logger.error('❌ Erreur lors de la réinitialisation', e, stackTrace);
      rethrow;
    }
  }

  /// Obtenir des informations sur l'état de l'app
  Future<Map<String, dynamic>> getAppStatus() async {
    try {
      final db = await DatabaseService.instance.database;

      final surahCount = await db.rawQuery(
        'SELECT COUNT(*) as count FROM quran_surahs',
      );
      final verseCount = await db.rawQuery(
        'SELECT COUNT(*) as count FROM quran_verses',
      );
      final hadithCount = await db.rawQuery(
        'SELECT COUNT(*) as count FROM hadiths',
      );
      final wordCount = await db.rawQuery(
        'SELECT COUNT(*) as count FROM vocabulary_words',
      );

      return {
        'is_initialized': _isInitialized,
        'data_loaded': _dataLoaded,
        'surahs': (surahCount.first['count'] as int),
        'verses': (verseCount.first['count'] as int),
        'hadiths': (hadithCount.first['count'] as int),
        'words': (wordCount.first['count'] as int),
      };
    } catch (e) {
      logger.error('❌ Erreur lors de la récupération du statut', e);
      return {
        'is_initialized': _isInitialized,
        'data_loaded': _dataLoaded,
        'error': e.toString(),
      };
    }
  }
}

// ============= IMPORTS NÉCESSAIRES =============
// À ajouter en haut du fichier:
/*
import 'features/quran/quran_repository.dart';
import 'features/hadith/hadith_repository.dart';
import 'features/vocabulary/vocabulary_repository.dart';
*/
