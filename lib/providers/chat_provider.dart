import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_message.dart';

/// Chat state notifier
class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier() : super(_getInitialMessages()) {
    _simulateBotResponse();
  }

  /// Add a new message from user
  void sendMessage(String text) {
    final message = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      timestamp: DateTime.now(),
      isFromUser: true,
      senderName: 'You',
    );

    state = [...state, message];

    // Simulate bot response after a delay
    _simulateBotResponse();
  }

  /// Simulate bot response
  void _simulateBotResponse() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        final botMessage = ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: _getRandomBotResponse(),
          timestamp: DateTime.now(),
          isFromUser: false,
          senderName: 'CareBot',
        );

        state = [...state, botMessage];
      }
    });
  }

  /// Get random bot response
  String _getRandomBotResponse() {
    final responses = [
      "Thank you for your message. How can I help you today?",
      "I understand your concern. Let me assist you with that.",
      "That's a great question! Here's what I can tell you...",
      "I'm here to help. Could you provide more details?",
      "Thank you for reaching out. I'll look into this for you.",
      "I appreciate your patience. Let me check on that.",
      "That's helpful information. I'll make a note of it.",
      "I'm sorry to hear about that. Let me see how I can help.",
    ];

    return responses[DateTime.now().millisecondsSinceEpoch % responses.length];
  }

  /// Clear chat history
  void clearChat() {
    state = _getInitialMessages();
  }

  /// Get initial messages
  static List<ChatMessage> _getInitialMessages() {
    return [
      ChatMessage(
        id: '1',
        text:
            "Hello! I'm CareBot, your virtual assistant. How can I help you today?",
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        isFromUser: false,
        senderName: 'CareBot',
      ),
    ];
  }
}

/// Chat provider
final chatProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>((
  ref,
) {
  return ChatNotifier();
});

/// Chat participants provider
final chatParticipantsProvider = Provider<List<ChatParticipant>>((ref) {
  return [
    const ChatParticipant(id: 'user', name: 'You', isOnline: true),
    const ChatParticipant(id: 'bot', name: 'CareBot', isOnline: true),
  ];
});
