import 'package:chatmailgpt/src/features/chats/presentation/chat_screen/chat_screen.dart';
import 'package:chatmailgpt/src/home_screen.dart';
import 'package:chatmailgpt/src/localization/string_hardcoded.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  home,
  chat,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false, // optional – log navigated paths in console
  routes: [
    GoRoute(
      path: '/',
      name: AppRoutes.home.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'chat/:id',
          name: AppRoutes.chat.name,
          builder: (context, state) {
            final chatId = state.pathParameters['id']!;
            return ChatScreen(chatId: chatId);
          },
        )
      ],
    ),
  ],
  errorBuilder: (context, state) => Text('Page not found!'.hardcoded),
);
