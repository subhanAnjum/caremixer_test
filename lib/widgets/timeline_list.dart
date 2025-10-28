import 'package:flutter/widgets.dart';

import '../models/timeline_entry.dart';
import 'timeline_entry_widget.dart';

/// Timeline list widget
class TimelineListWidget extends StatelessWidget {
  final List<TimelineEntry> entries;

  const TimelineListWidget({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        final isLast = index == entries.length - 1;

        return TimelineEntryWidget(entry: entry, isLast: isLast);
      },
    );
  }
}
