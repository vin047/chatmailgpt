import 'package:chatmailgpt/src/common_widgets/async_value_shimmer_widget.dart';
import 'package:chatmailgpt/src/common_widgets/text_block_wrapper.dart';
import 'package:chatmailgpt/src/constants/app_sizes.dart';
import 'package:chatmailgpt/src/features/chats/data/local/fake_local_chat_repository.dart';
import 'package:chatmailgpt/src/features/chats/data/local/local_chat_repository.dart';
import 'package:chatmailgpt/src/features/chats/domain/message.dart';
import 'package:chatmailgpt/src/utils/text_overflow_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatScreenItemId =
    Provider.autoDispose<MessageID>((_) => throw UnimplementedError());
final chatScreenItemExpand =
    StateProvider.autoDispose<bool>((_) => throw UnimplementedError());

class ChatScreenItem extends ConsumerWidget {
  const ChatScreenItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageId = ref.watch(chatScreenItemId);
    final message = ref.watch(messageFutureProvider(messageId));
    final messagePlaceholder =
        ref.watch(fakeLocalChatRepositoryProvider).messages.last;
    final expand = ref.watch(chatScreenItemExpand);
    return AsyncValueShimmerWidget(
      value: message,
      loading: () => _ChatScreenItemRow(
        message: messagePlaceholder,
        wrapInBox: true,
        expand: expand,
        selectable: false,
      ),
      data: (message) => message == null
          ? const Text('error')
          : GestureDetector(
              onTap: () =>
                  ref.read(chatScreenItemExpand.notifier).state = !expand,
              behavior: HitTestBehavior.translucent,
              child: _ChatScreenItemRow(
                message: message,
                wrapInBox: false,
                expand: expand,
                selectable: expand,
              ),
            ),
    );
  }
}

class _ChatScreenItemRow extends StatelessWidget {
  const _ChatScreenItemRow({
    required this.message,
    required this.wrapInBox,
    required this.expand,
    required this.selectable,
  });

  final Message message;
  final bool wrapInBox; // wraps Text widgets in Container, for shimmer effect
  final bool expand;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.p8, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(Sizes.p4),
            child: wrapInBox
                ? TextBlockWrapper(
                    child: _AuthorWidget(message: message),
                  )
                : _AuthorWidget(message: message),
          ),
          Padding(
            padding: const EdgeInsets.all(Sizes.p4),
            child: wrapInBox
                ? TextBlockWrapper(
                    child: _ContentWidget(
                      message: message,
                      expand: expand,
                      selectable: selectable,
                    ),
                  )
                : _ContentWidget(
                    message: message,
                    expand: expand,
                    selectable: selectable,
                  ),
          ),
        ],
      ),
    );
  }
}

class _AuthorWidget extends StatelessWidget {
  const _AuthorWidget({
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message.author == 'assistant' ? 'ChatGPT' : 'me',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    required this.message,
    required this.expand,
    required this.selectable,
  });

  final Message message;
  final bool expand;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textWillOverflow = textOverflowCheck(
          message.content,
          Theme.of(context).textTheme.bodyMedium!,
          minWidth: constraints.minWidth,
          maxWidth: constraints.maxWidth,
          maxLines: expand ? null : 1,
        );
        if (selectable || !textWillOverflow) {
          return SelectableText(
            message.content,
            style: Theme.of(context).textTheme.bodyMedium,
          );
        } else {
          return Text(
            message.content,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: expand ? null : 1,
            overflow: expand ? null : TextOverflow.ellipsis,
          );
        }
      },
    );
  }
}
