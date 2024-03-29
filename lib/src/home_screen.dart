import 'package:chatmailgpt/src/features/chats/presentation/chat_list_screen/chat_list_screen.dart';
import 'package:chatmailgpt/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat List'.hardcoded),
      ),
      body: const ChatListScreen(),
    );
  }
}
