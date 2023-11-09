import 'package:chatmailgpt/src/features/chats/domain/chat.dart';
import 'package:chatmailgpt/src/features/chats/domain/message.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class LocalChatRepository {
  Future<List<ChatID>> fetchChatIdsList();
  Future<Chat?> fetchChat(ChatID id);
  Future<Message?> fetchMessage(MessageID id);
}

final localChatRepositoryProvider = Provider<LocalChatRepository>((ref) {
  throw UnimplementedError();
});

final chatIdsListFutureProvider =
    FutureProvider.autoDispose<List<ChatID>>((ref) {
  final repository = ref.watch(localChatRepositoryProvider);
  return repository.fetchChatIdsList();
});

final chatFutureProvider =
    FutureProvider.autoDispose.family<Chat?, ChatID>((ref, id) {
  final repository = ref.watch(localChatRepositoryProvider);
  return repository.fetchChat(id);
});

final messageFutureProvider =
    FutureProvider.autoDispose.family<Message?, MessageID>((ref, id) {
  final repository = ref.watch(localChatRepositoryProvider);
  return repository.fetchMessage(id);
});
