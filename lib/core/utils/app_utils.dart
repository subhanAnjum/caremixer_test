import 'package:flutter/material.dart';

/// Utility functions for the app
class AppUtils {
  /// Format timestamp to readable string
  static String formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  /// Format time for chat messages
  static String formatChatTime(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  /// Get appropriate icon for timeline entry type
  static IconData getTimelineIcon(String type) {
    switch (type.toLowerCase()) {
      case 'note':
        return Icons.note;
      case 'audit':
        return Icons.security;
      case 'alert':
        return Icons.warning;
      case 'success':
        return Icons.check_circle;
      default:
        return Icons.info;
    }
  }

  /// Get appropriate color for timeline entry type
  static Color getTimelineColor(String type) {
    switch (type.toLowerCase()) {
      case 'note':
        return CaremixerColors.lightCoral;
      case 'audit':
        return CaremixerColors.lightGreen;
      case 'alert':
        return CaremixerColors.darkRed;
      case 'success':
        return CaremixerColors.green;
      default:
        return CaremixerColors.grey;
    }
  }

  /// Show snackbar with error message
  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: CaremixerColors.darkRed,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Show snackbar with success message
  static void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: CaremixerColors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

/// Caremixer color palette (imported from theme)
class CaremixerColors {
  static const Color lightCoral = Color(0xFFffd8cf);
  static const Color lightGreen = Color(0xFFe2f7e6);
  static const Color orange = Color(0xFFf05226);
  static const Color mintGreen = Color(0xFFc1e0c7);
  static const Color darkRed = Color(0xFFbd3b27);
  static const Color green = Color(0xFF84cc8f);
  static const Color darkBrown = Color(0xFF6b1300);
  static const Color darkGreen = Color(0xFF345136);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF757575);
  static const Color lightGrey = Color(0xFFF5F5F5);
}
