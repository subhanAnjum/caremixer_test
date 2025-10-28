/// Chat message model
class ChatMessage {
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isFromUser;
  final String? senderName;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isFromUser,
    this.senderName,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'] as String,
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isFromUser: json['isFromUser'] as bool,
      senderName: json['senderName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'isFromUser': isFromUser,
      'senderName': senderName,
    };
  }
}

/// Chat participant model
class ChatParticipant {
  final String id;
  final String name;
  final String? avatarUrl;
  final bool isOnline;

  const ChatParticipant({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.isOnline = false,
  });

  factory ChatParticipant.fromJson(Map<String, dynamic> json) {
    return ChatParticipant(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'isOnline': isOnline,
    };
  }
}
