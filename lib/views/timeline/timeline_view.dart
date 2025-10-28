import 'package:flutter/material.dart';
import '../../models/timeline_entry.dart';
import '../../widgets/timeline_list.dart';

/// Timeline view screen
class TimelineView extends StatelessWidget {
  const TimelineView({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = TimelineDataService.getHardcodedEntries();

    return Scaffold(
      appBar: AppBar(title: const Text('Timeline')),
      body: TimelineListWidget(entries: entries),
    );
  }
}
