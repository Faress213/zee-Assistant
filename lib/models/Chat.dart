import 'package:newvirus/models/Message.dart';

class Chat {
  final String id;
  final String title;
  final List<Message> messages;
  final Chatstatus status;
  Chat({required this.id, required this.title, required this.messages,required this.status});

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(id: json['id'], title: json['title'], messages: json['messages'],
    status: json['status']);
  }
}
enum Chatstatus{
  online,
  offline,
}