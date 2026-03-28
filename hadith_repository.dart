import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

import 'config/app_initializer.dart';
import 'core/db/database_service.dart';
import 'core/services/ai_service.dart';
import 'core/services/logger_service.dart';
import 'features/quran/quran_repository.dart';
import 'features/hadith/hadith_repository.dart';
import 'features/vocabulary/vocabulary_repository.dart';

// ============= SERVICES PROVIDERS =============

/// Logger Service
final loggerProvider = Provider((ref) {
  return LoggerService();
});

/// AI Service
final aiServiceProvider = FutureProvider((ref) async {
  final aiService = AIService();
  await aiService.initialize();
  return aiService;
});

/// Database Provider
final databaseProvider = FutureProvider<Database>((ref) async {
  return await DatabaseService.instance.database;
});

/// App Initializer
final appInitializerProvider = Provider((ref) {
  return AppInitializer();
});

// ============= REPOSITORY PROVIDERS =============

/// Quran Repository
final quranRepositoryProvider = FutureProvider<QuranRepository>((ref) async {
  final db = await ref.watch(databaseProvider.future);
  return QuranRepository(database: db);
});

/// Hadith Repository
final hadithRepositoryProvider = FutureProvider<HadithRepository>((ref) async {
  final db = await ref.watch(databaseProvider.future);
  return HadithRepository(database: db);
});

/// Vocabulary Repository
final vocabularyRepositoryProvider =
    FutureProvider<VocabularyRepository>((ref) async {
  final db = await ref.watch(databaseProvider.future);
  return VocabularyRepository(database: db);
});

// ============= DATA PROVIDERS =============

/// Récupérer toutes les Sourates
final quranSurahsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repo = await ref.watch(quranRepositoryProvider.future);
  return await repo.getAllSurahs();
});

/// Récupérer une Sourate spécifique
final quranSurahProvider =
    FutureProvider.family<Map<String, dynamic>?, int>((ref, surahNumber) async {
  final repo = await ref.watch(quranRepositoryProvider.future);
  return await repo.getSurah(surahNumber);
});

/// Récupérer les versets d'une Sourate
final quranVersesProvider =
    FutureProvider.family<List<Map<String, dynamic>>, int>(
  (ref, surahNumber) async {
    final repo = await ref.watch(quranRepositoryProvider.future);
    return await repo.getVersesBySurah(surahNumber);
  },
);

/// Rechercher des versets
final quranSearchProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
  (ref, query) async {
    if (query.isEmpty) return [];
    final repo = await ref.watch(quranRepositoryProvider.future);
    return await repo.searchVerses(query);
  },
);

/// Récupérer les favoris Coran
final quranBookmarksProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repo = await ref.watch(quranRepositoryProvider.future);
  return await repo.getBookmarks();
});

// ============= HADITH PROVIDERS =============

/// Récupérer les collections de Hadith
final hadithCollectionsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repo = await ref.watch(hadithRepositoryProvider.future);
  return await repo.getCollections();
});

/// Récupérer les hadiths d'une collection
final hadithsByCollectionProvider = FutureProvider.family<
    List<Map<String, dynamic>>,
    ({int collectionId, int limit, int offset})>(
  (ref, params) async {
    final repo = await ref.watch(hadithRepositoryProvider.future);
    return await repo.getHadithsByCollection(
      params.collectionId,
      limit: params.limit,
      offset: params.offset,
    );
  },
);

/// Chercher un hadith spécifique
final hadithProvider = FutureProvider.family<Map<String, dynamic>?, int>(
  (ref, hadithId) async {
    final repo = await ref.watch(hadithRepositoryProvider.future);
    return await repo.getHadith(hadithId);
  },
);

/// Rechercher des hadiths
final hadithSearchProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
  (ref, query) async {
    if (query.isEmpty) return [];
    final repo = await ref.watch(hadithRepositoryProvider.future);
    return await repo.searchHadiths(query);
  },
);

/// Statistiques Hadith
final hadithStatsProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  final repo = await ref.watch(hadithRepositoryProvider.future);
  return await repo.getCollectionStats();
});

// ============= VOCABULARY PROVIDERS =============

/// Récupérer les ensembles de vocabulaire
final vocabularySetsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repo = await ref.watch(vocabularyRepositoryProvider.future);
  return await repo.getVocabularySets();
});

/// Récupérer les mots d'un ensemble
final vocabularyWordsProvider = FutureProvider.family<
    List<Map<String, dynamic>>,
    ({int setId, int limit})>(
  (ref, params) async {
    final repo = await ref.watch(vocabularyRepositoryProvider.future);
    return await repo.getWordsBySet(params.setId, limit: params.limit);
  },
);

/// Récupérer l'alphabet
final alphabetProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final repo = await ref.watch(vocabularyRepositoryProvider.future);
  return await repo.getAlphabet();
});

/// Récupérer une lettre spécifique
final alphabetLetterProvider =
    FutureProvider.family<Map<String, dynamic>?, int>(
  (ref, letterNumber) async {
    final repo = await ref.watch(vocabularyRepositoryProvider.future);
    return await repo.getLetter(letterNumber);
  },
);

/// Rechercher un mot
final vocabularySearchProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
  (ref, query) async {
    if (query.isEmpty) return [];
    final repo = await ref.watch(vocabularyRepositoryProvider.future);
    return await repo.searchWords(query);
  },
);

/// Statistiques vocabulaire
final vocabularyStatsProvider =
    FutureProvider<Map<String, dynamic>>((ref) async {
  final repo = await ref.watch(vocabularyRepositoryProvider.future);
  return await repo.getVocabularyStats();
});

// ============= STATE PROVIDERS (Mutable State) =============

/// Search Query State
final searchQueryProvider = StateProvider<String>((ref) {
  return '';
});

/// Selected Surah State
final selectedSurahProvider = StateProvider<int?>((ref) {
  return null;
});

/// Selected Hadith Collection State
final selectedHadithCollectionProvider = StateProvider<int?>((ref) {
  return null;
});

/// User Progress State
final userProgressProvider = StateProvider<Map<String, int>>((ref) {
  return {};
});

/// Bookmarks State
final bookmarksProvider = StateProvider<List<String>>((ref) {
  return [];
});

// ============= COMPUTED PROVIDERS =============

/// Filtered Surahs based on search
final filteredSurahsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final surahs = await ref.watch(quranSurahsProvider.future);
  final query = ref.watch(searchQueryProvider);

  if (query.isEmpty) return surahs;

  return surahs
      .where((surah) =>
          surah['name_arabic'].toString().contains(query) ||
          surah['name_transliteration'].toString().contains(query) ||
          surah['name_english'].toString().contains(query))
      .toList();
});

/// App Status
final appStatusProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final initializer = ref.watch(appInitializerProvider);
  return await initializer.getAppStatus();
});

/// Is App Ready
final isAppReadyProvider = FutureProvider<bool>((ref) async {
  final status = await ref.watch(appStatusProvider.future);
  return status['is_initialized'] as bool;
});

/// Data Loaded Count
final dataLoadedCountProvider = FutureProvider<int>((ref) async {
  final stats = await ref.watch(vocabularyStatsProvider.future);
  return (stats['words'] as int) +
      (stats['alphabet_letters'] as int);
});

// ============= ERROR HANDLING =============

/// Global Error Handler
class ErrorNotifier extends StateNotifier<String?> {
  ErrorNotifier() : super(null);

  void setError(String? error) {
    state = error;
  }

  void clearError() {
    state = null;
  }
}

final errorNotifierProvider =
    StateNotifierProvider<ErrorNotifier, String?>((ref) {
  return ErrorNotifier();
});

// ============= EXPORTS =============

export 'config/app_initializer.dart';
export 'core/db/database_service.dart';
export 'core/services/ai_service.dart';
export 'core/services/logger_service.dart';
export 'features/quran/quran_repository.dart';
export 'features/hadith/hadith_repository.dart';
export 'features/vocabulary/vocabulary_repository.dart';
