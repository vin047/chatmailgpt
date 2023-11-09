import 'package:chatmailgpt/src/constants/test_chats.dart';
import 'package:chatmailgpt/src/constants/test_messages.dart';
import 'package:chatmailgpt/src/features/chats/data/local/local_chat_repository.dart';
import 'package:chatmailgpt/src/features/chats/domain/chat.dart';
import 'package:chatmailgpt/src/features/chats/domain/message.dart';
import 'package:chatmailgpt/src/utils/delay.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeLocalChatRepository implements LocalChatRepository {
  FakeLocalChatRepository({this.addDelay = true});

  final bool addDelay;
  final _chats = kTestChats;
  final _messages = kTestMessages;

  List<ChatID> get chatIds => _chats.map((chat) => chat.id).toList();
  List<Chat> get chats => _chats;
  List<Message> get messages => _messages;

  @override
  Future<List<ChatID>> fetchChatIdsList() async {
    await delay(addDelay);
    return Future.value(_chats.map((chat) => chat.id).toList());
  }

  @override
  Future<Chat?> fetchChat(ChatID id) async {
    await delay(addDelay);
    return Future.value(_getChat(_chats, id));
  }

  @override
  Future<Message?> fetchMessage(MessageID id) async {
    await delay(addDelay);
    return Future.value(_getMessage(_messages, id));
  }

  static Chat? _getChat(List<Chat> chats, ChatID id) {
    try {
      return chats.firstWhere((chat) => chat.id == id);
    } catch (e) {
      return null;
    }
  }

  static Message? _getMessage(List<Message> messages, MessageID id) {
    try {
      return messages.firstWhere((message) => message.id == id);
    } catch (e) {
      return null;
    }
  }
}

final fakeLocalChatRepositoryProvider =
    Provider<FakeLocalChatRepository>((ref) {
  return FakeLocalChatRepository();
});
