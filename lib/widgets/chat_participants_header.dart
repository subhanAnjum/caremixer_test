import 'package:caremixer_assessment/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/app_utils.dart';

/// Chat participants header
class ChatParticipantsHeader extends ConsumerWidget {
  const ChatParticipantsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final participants = ref.watch(chatParticipantsProvider);

    return Container(
      height: Theme.of(context).appBarTheme.toolbarHeight ?? 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color:
            Theme.of(context).appBarTheme.backgroundColor ??
            CaremixerColors.orange,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.chat, color: CaremixerColors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CareBot Chat',
                  style: TextStyle(
                    color: CaremixerColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${participants.length} participants',
                  style: const TextStyle(
                    color: CaremixerColors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.clear_all, color: CaremixerColors.white),
            onPressed: () {
              ref.read(chatProvider.notifier).clearChat();
              AppUtils.showSuccessSnackBar(context, 'Chat cleared');
            },
          ),
        ],
      ),
    );
  }
}
