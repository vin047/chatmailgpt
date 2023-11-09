import 'package:chatmailgpt/src/common_widgets/async_value_widget.dart';
import 'package:chatmailgpt/src/constants/app_sizes.dart';
import 'package:chatmailgpt/src/features/chats/data/local/local_chat_repository.dart';
import 'package:chatmailgpt/src/features/chats/presentation/chat_list_screen/chat_list_screen_item.dart';
import 'package:chatmailgpt/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatIdsList = ref.watch(chatIdsListFutureProvider);
    return AsyncValueWidget(
      value: chatIdsList,
      data: (chatIdsList) => chatIdsList.isEmpty
          ? Text('No chats found'.hardcoded)
          : ListView.separated(
              restorationId: 'chatListScreen',
              itemCount: chatIdsList.length,
              itemBuilder: (BuildContext context, int index) {
                final chatId = chatIdsList[index];
                return ProviderScope(
                  overrides: [
                    chatListScreenItemId.overrideWithValue(chatId),
                  ],
                  child: const ChatListScreenItem(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: Sizes.p8);
              },
            ),
    );
  }
}
