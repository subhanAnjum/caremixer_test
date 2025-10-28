import 'package:flutter/material.dart';
import '../../core/utils/app_utils.dart';
import '../../models/chat_message.dart';

/// Chat message bubble widget
class ChatBubble extends StatefulWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(
          begin: widget.message.isFromUser
              ? const Offset(1.0, 0.0)
              : const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 4.0,
              ),
              child: Row(
                mainAxisAlignment: widget.message.isFromUser
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  if (!widget.message.isFromUser) ...[
                    _buildAvatar(),
                    const SizedBox(width: 8),
                  ],
                  Flexible(child: _buildBubble(isDarkMode)),
                  if (widget.message.isFromUser) ...[
                    const SizedBox(width: 8),
                    _buildAvatar(),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 16,
      backgroundColor: widget.message.isFromUser
          ? CaremixerColors.orange
          : CaremixerColors.green,
      child: Text(
        widget.message.isFromUser ? 'U' : 'B',
        style: const TextStyle(
          color: CaremixerColors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildBubble(isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: CaremixerColors.grey.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        color: widget.message.isFromUser
            ? CaremixerColors.orange
            : isDarkMode
            ? CaremixerColors.grey
            : CaremixerColors.lightGrey,
        borderRadius: BorderRadius.circular(20).copyWith(
          bottomLeft: widget.message.isFromUser
              ? const Radius.circular(20)
              : const Radius.circular(4),
          bottomRight: widget.message.isFromUser
              ? const Radius.circular(4)
              : const Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.message.text,
            style: TextStyle(
              color: widget.message.isFromUser
                  ? CaremixerColors.white
                  : isDarkMode
                  ? CaremixerColors.white
                  : CaremixerColors.darkGreen,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppUtils.formatChatTime(widget.message.timestamp),
            style: TextStyle(
              color: widget.message.isFromUser
                  ? CaremixerColors.white.withValues(alpha: 0.7)
                  : isDarkMode
                  ? CaremixerColors.white.withValues(alpha: 0.7)
                  : CaremixerColors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
