import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Screens imports (will be created next)
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../features/quran/presentation/screens/quran_list_screen.dart';
import '../features/quran/presentation/screens/surah_detail_screen.dart';
import '../features/arabic_learning/presentation/screens/learning_screen.dart';
import '../features/ai_tutor/presentation/screens/ai_tutor_screen.dart';
import '../features/hadith/presentation/screens/hadith_list_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page not found'),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
    routes: [
      // Splash
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // Dashboard
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),

      // Quran
      GoRoute(
        path: '/quran',
        name: 'quran_list',
        builder: (context, state) => const QuranListScreen(),
        routes: [
          GoRoute(
            path: 'surah/:surahId',
            name: 'surah_detail',
            builder: (context, state) {
              final surahId = state.pathParameters['surahId']!;
              return SurahDetailScreen(surahId: surahId);
            },
          ),
        ],
      ),

      // Arabic Learning
      GoRoute(
        path: '/learn',
        name: 'learn',
        builder: (context, state) => const LearningScreen(),
      ),

      // AI Tutor
      GoRoute(
        path: '/tutor',
        name: 'tutor',
        builder: (context, state) => const AiTutorScreen(),
      ),

      // Hadith
      GoRoute(
        path: '/hadith',
        name: 'hadith_list',
        builder: (context, state) => const HadithListScreen(),
      ),

      // Settings
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});

// Extension for easy navigation
extension GoRouterX on GoRouter {
  void goHome() => go('/dashboard');
  void goQuran() => go('/quran');
  void goLearn() => go('/learn');
  void goTutor() => go('/tutor');
  void goHadith() => go('/hadith');
  void goSettings() => go('/settings');
  void goSurahDetail(String surahId) => push('/quran/surah/$surahId');
}
