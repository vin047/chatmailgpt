import 'package:chatmailgpt/src/common_widgets/async_value_widget.dart';
import 'package:chatmailgpt/src/constants/app_sizes.dart';
import 'package:chatmailgpt/src/features/chats/data/local/local_chat_repository.dart';
import 'package:chatmailgpt/src/features/chats/domain/chat.dart';
import 'package:chatmailgpt/src/features/chats/presentation/chat_screen/chat_screen_item.dart';
import 'package:chatmailgpt/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.chatId});

  final ChatID chatId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer(
          builder: (context, ref, child) {
            final chat = ref.watch(chatFutureProvider(chatId));
            return AsyncValueWidget(
              value: chat,
              data: (chat) => chat == null
                  ? Text('Chat not found'.hardcoded)
                  : ListView.separated(
                      restorationId: 'chatScreen',
                      itemCount: chat.messageIds.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.all(Sizes.p12),
                            child: Text(
                              chat.heading,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          );
                        }
                        index -= 1;
                        final messageId = chat.messageIds[index];
                        return ProviderScope(
                          overrides: [
                            chatScreenItemId.overrideWith((ref) => messageId),
                            chatScreenItemExpand.overrideWith(
                                (ref) => index == chat.messageIds.length - 1),
                          ],
                          child: const ChatScreenItem(),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
            );
          },
        ));
  }
}
