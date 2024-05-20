import 'package:chat/user.dart';

class Message {
  final User sender;
  final User recipient;
  final String content;
  final DateTime timestamp;
  final int? hebergementId;

  Message({
    required this.sender,
    required this.recipient,
    required this.content,
    required this.timestamp,
    this.hebergementId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      sender: User.fromJson(json['sender']),
      recipient: User.fromJson(json['recipient']),
      content: json['content'] ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
      hebergementId:
          json['hebergementId'] != null ? json['hebergementId'] as int : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender.toJson(),
      'recipient': recipient.toJson(),
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'hebergementId': hebergementId,
    };
  }
}
