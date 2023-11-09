import 'package:chatmailgpt/src/features/chats/domain/chat.dart';

final kTestChats = [
  Chat(
      id: '1',
      heading: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      messageIds: ['1', '2', '3', '4'],
      createTime: DateTime.parse('2023-06-01 00:00:00')),
  Chat(
      id: '2',
      heading:
          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      messageIds: ['5', '6', '7', '8'],
      createTime: DateTime.parse('2023-06-02 00:00:00')),
  Chat(
      id: '3',
      heading: 'Ut enim ad minim veniam',
      messageIds: ['9', '10', '11', '12'],
      createTime: DateTime.parse('2023-06-03 00:00:00')),
  Chat(
      id: '4',
      heading:
          'Quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      messageIds: ['13', '14', '15', '16'],
      createTime: DateTime.parse('2023-06-04 00:00:00')),
];
