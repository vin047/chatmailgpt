import 'package:chatmailgpt/src/common_widgets/async_value_shimmer_widget.dart';
import 'package:chatmailgpt/src/common_widgets/text_block_wrapper.dart';
import 'package:chatmailgpt/src/constants/app_sizes.dart';
import 'package:chatmailgpt/src/features/chats/data/local/fake_local_chat_repository.dart';
import 'package:chatmailgpt/src/features/chats/data/local/local_chat_repository.dart';
import 'package:chatmailgpt/src/features/chats/domain/chat.dart';
import 'package:chatmailgpt/src/localization/string_hardcoded.dart';
import 'package:chatmailgpt/src/routing/app_router.dart';
import 'package:chatmailgpt/src/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/src/intl/date_format.dart';

final chatListScreenItemId =
    Provider.autoDispose<ChatID>((_) => throw UnimplementedError());

class ChatListScreenItem extends ConsumerWidget {
  const ChatListScreenItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatId = ref.watch(chatListScreenItemId);
    final chat = ref.watch(chatFutureProvider(chatId));
    final chatPlaceholder =
        ref.watch(fakeLocalChatRepositoryProvider).chats.last;
    final dateFormatter = ref.watch(dateFormatterProvider);
    return AsyncValueShimmerWidget(
      value: chat,
      loading: () => _ChatListScreenItemRow(
        chat: chatPlaceholder,
        dateFormatter: dateFormatter,
        wrapInBox: true,
        onTap: null,
      ),
      data: (chat) => chat == null
          ? Text('Chat not found'.hardcoded)
          : _ChatListScreenItemRow(
              chat: chat,
              dateFormatter: dateFormatter,
              wrapInBox: false,
              onTap: () => context.goNamed(
                AppRoutes.chat.name,
                pathParameters: {'id': chatId},
              ),
            ),
    );
  }
}

class _ChatListScreenItemRow extends StatelessWidget {
  const _ChatListScreenItemRow({
    required this.chat,
    required this.dateFormatter,
    required this.wrapInBox,
    required this.onTap,
  });

  final Chat chat;
  final DateFormat dateFormatter;
  final bool wrapInBox; // wraps Text widgets in Container, for shimmer effect
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: wrapInBox
          ? TextBlockWrapper(
              child: _Title(chat: chat),
            )
          : _Title(chat: chat),
      trailing: wrapInBox
          ? TextBlockWrapper(
              child: _Trailing(
                dateFormatter: dateFormatter,
                chat: chat,
              ),
            )
          : _Trailing(
              dateFormatter: dateFormatter,
              chat: chat,
            ),
      onTap: onTap,
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -Sizes.p4),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.chat,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            chat.heading,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(Sizes.p4),
          child: Text(
            chat.messageIds.length.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

class _Trailing extends StatelessWidget {
  const _Trailing({
    required this.dateFormatter,
    required this.chat,
  });

  final DateFormat dateFormatter;
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return Text(
      dateFormatter.format(chat.createTime),
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
