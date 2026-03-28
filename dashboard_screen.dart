import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

import '../core/db/database_service.dart';
import '../core/services/ai_service.dart';
import '../core/services/logger_service.dart';

// =======================
// DATABASE PROVIDERS
// =======================

final databaseProvider = FutureProvider<Database>((ref) async {
  return await DatabaseService.instance.database;
});

// =======================
// SERVICE PROVIDERS
// =======================

final loggerServiceProvider = Provider((ref) {
  return LoggerService();
});

final aiServiceProvider = FutureProvider((ref) async {
  final ai = AIService();
  await ai.initialize();
  return ai;
});

// =======================
// INITIALIZATION
// =======================

Future<void> initializeDependencies() async {
  // Initialize database
  await DatabaseService.instance.database;
  
  // Initialize logger
  if (kDebugMode) {
    print('🚀 AYA CLAUDE initialized successfully');
  }
}
