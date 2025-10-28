import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/chat_provider.dart';
import '../../widgets/chat_bubble.dart';
import '../../widgets/chat_input_field.dart';
import '../../widgets/chat_participants_header.dart';

/// Chat view screen
class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage(String text) {
    ref.read(chatProvider.notifier).sendMessage(text);

    // Scroll to bottom after sending message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatProvider);

    // Auto-scroll when new messages arrive
    ref.listen(chatProvider, (previous, next) {
      if (previous != null && next.length > previous.length) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      }
    });

    return GestureDetector(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).padding.top,
              color: Theme.of(context).appBarTheme.backgroundColor,
            ),
            const ChatParticipantsHeader(),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(message: messages[index]);
                },
              ),
            ),
            ChatInputField(onSendMessage: _sendMessage),
          ],
        ),
      ),
    );
  }
}
