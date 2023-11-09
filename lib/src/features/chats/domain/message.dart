// ignore_for_file: public_member_api_docs, sort_constructors_first
typedef MessageID = String;

class Message {
  const Message(
      {required this.id,
      required this.content,
      required this.createTime,
      required this.author});

  final MessageID id;
  final String content;
  final DateTime createTime;
  final String author;

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.content == content &&
        other.createTime == createTime &&
        other.author == author;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        content.hashCode ^
        createTime.hashCode ^
        author.hashCode;
  }

  @override
  String toString() {
    return 'Message(id: $id, content: $content, createTime: $createTime, author: $author)';
  }
}
