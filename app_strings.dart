import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/router.dart';
import 'config/dependency_injection.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  await initializeDependencies();
  
  runApp(
    const ProviderScope(
      child: AyaClaudeApp(),
    ),
  );
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
      debugShowCheckedModeBanner: false,
    );
  }
}
