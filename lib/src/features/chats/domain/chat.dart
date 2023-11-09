// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatmailgpt/src/features/chats/domain/message.dart';
import 'package:flutter/foundation.dart';

typedef ChatID = String;

class Chat {
  const Chat({
    required this.id,
    required this.heading,
    required this.messageIds,
    required this.createTime,
  });

  final ChatID id;
  final String heading;
  final List<MessageID> messageIds;
  final DateTime createTime;

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.heading == heading &&
        listEquals(other.messageIds, messageIds) &&
        other.createTime == createTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        heading.hashCode ^
        messageIds.hashCode ^
        createTime.hashCode;
  }

  @override
  String toString() {
    return 'Chat(id: $id, heading: $heading, messageIds: $messageIds, createTime: $createTime)';
  }
}
