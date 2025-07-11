class Message {
  final Role role;
  final String content;

  Message({required this.role, required this.content});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(role: json['role'], content: json['content']);
  }
}
enum Role {
  system,
  user,
  assistant,
}
