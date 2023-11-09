import 'package:chatmailgpt/src/home_screen.dart';
import 'package:chatmailgpt/src/localization/string_hardcoded.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  home,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false, // optional – log navigated paths in console
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.home.name,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
  errorBuilder: (context, state) => Text('Page not found!'.hardcoded),
);
