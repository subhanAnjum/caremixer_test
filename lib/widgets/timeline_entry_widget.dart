import 'package:flutter/material.dart';
import '../../core/utils/app_utils.dart';
import '../../models/timeline_entry.dart';

/// Timeline entry widget
class TimelineEntryWidget extends StatefulWidget {
  final TimelineEntry entry;
  final bool isLast;

  const TimelineEntryWidget({
    super.key,
    required this.entry,
    this.isLast = false,
  });

  @override
  State<TimelineEntryWidget> createState() => _TimelineEntryWidgetState();
}

class _TimelineEntryWidgetState extends State<TimelineEntryWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.3, 0.0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    // Start animation with a slight delay
    Future.delayed(
      Duration(milliseconds: widget.entry.timestamp.millisecond % 300),
      () {
        if (mounted) {
          _animationController.forward();
        }
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Timeline dot and line
                    _buildTimelineIndicator(),
                    const SizedBox(width: 16),
                    // Content
                    Expanded(child: _buildContent()),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTimelineIndicator() {
    return Column(
      children: [
        // Timeline dot
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: AppUtils.getTimelineColor(widget.entry.type),
            shape: BoxShape.circle,
            border: Border.all(color: CaremixerColors.white, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppUtils.getTimelineColor(
                  widget.entry.type,
                ).withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            AppUtils.getTimelineIcon(widget.entry.type),
            size: 12,
            color: CaremixerColors.white,
          ),
        ),

        if (!widget.isLast)
          Expanded(
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                color: CaremixerColors.white,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildContent() {
    final isImportant = _isImportantEvent(widget.entry.type);
    final highlightColor = _getHighlightColor(widget.entry.type);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: isImportant ? 4 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isImportant
              ? BorderSide(
                  color: highlightColor.withValues(alpha: 0.3),
                  width: 1,
                )
              : BorderSide.none,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: isImportant
                ? Border(left: BorderSide(color: highlightColor, width: 4))
                : null,
          ),
          child: Container(
            decoration: isImportant
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: highlightColor.withValues(alpha: 0.05),
                  )
                : null,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and timestamp
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            if (isImportant) ...[
                              Icon(
                                AppUtils.getTimelineIcon(widget.entry.type),
                                size: 18,
                                color: highlightColor,
                              ),
                              const SizedBox(width: 8),
                            ],
                            Expanded(
                              child: Text(
                                widget.entry.title,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontWeight: isImportant
                                          ? FontWeight.w700
                                          : FontWeight.w600,
                                      color: isImportant
                                          ? highlightColor
                                          : null,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        AppUtils.formatTimestamp(widget.entry.timestamp),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: CaremixerColors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Message
                  Text(
                    widget.entry.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  // Author (if available)
                  if (widget.entry.author != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: CaremixerColors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.entry.author!,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: CaremixerColors.grey,
                                fontStyle: FontStyle.italic,
                              ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Check if the event type is important
  bool _isImportantEvent(String type) {
    return type.toLowerCase() == 'success' || type.toLowerCase() == 'alert';
  }

  /// Get the highlight color for important events
  Color _getHighlightColor(String type) {
    switch (type.toLowerCase()) {
      case 'success':
        return CaremixerColors.green;
      case 'alert':
        return CaremixerColors.darkRed;
      default:
        return CaremixerColors.grey;
    }
  }
}
