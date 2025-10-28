/// Timeline entry model
class TimelineEntry {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final String type; // 'note', 'audit', 'alert', 'success'
  final String? author;

  const TimelineEntry({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.type,
    this.author,
  });

  factory TimelineEntry.fromJson(Map<String, dynamic> json) {
    return TimelineEntry(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: json['type'] as String,
      author: json['author'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'type': type,
      'author': author,
    };
  }
}

/// Timeline data service with hardcoded entries
class TimelineDataService {
  static List<TimelineEntry> getHardcodedEntries() {
    final now = DateTime.now();

    return [
      TimelineEntry(
        id: '1',
        title: 'Patient Check-in Completed',
        message:
            'John Doe successfully checked in for his appointment. All required forms have been completed.',
        timestamp: now.subtract(const Duration(minutes: 5)),
        type: 'success',
        author: 'Dr. Smith',
      ),
      TimelineEntry(
        id: '2',
        title: 'Vital Signs Recorded',
        message:
            'Blood pressure: 120/80, Heart rate: 72 bpm, Temperature: 98.6°F. All readings within normal range.',
        timestamp: now.subtract(const Duration(minutes: 15)),
        type: 'note',
        author: 'Nurse Johnson',
      ),
      TimelineEntry(
        id: '3',
        title: 'Medication Review',
        message:
            'Patient reported taking prescribed medications as directed. No adverse reactions noted.',
        timestamp: now.subtract(const Duration(minutes: 30)),
        type: 'audit',
        author: 'Dr. Smith',
      ),
      TimelineEntry(
        id: '4',
        title: 'Lab Results Available',
        message:
            'Blood work results have been processed and are ready for review. All values within normal limits.',
        timestamp: now.subtract(const Duration(hours: 1)),
        type: 'success',
        author: 'Lab Technician',
      ),
      TimelineEntry(
        id: '5',
        title: 'Allergy Alert',
        message:
            'Patient has known allergy to penicillin. Ensure all medications are checked for contraindications.',
        timestamp: now.subtract(const Duration(hours: 2)),
        type: 'alert',
        author: 'System',
      ),
      TimelineEntry(
        id: '6',
        title: 'Insurance Verification',
        message:
            'Patient insurance coverage confirmed. Copay amount: \$25.00. Prior authorization not required.',
        timestamp: now.subtract(const Duration(hours: 3)),
        type: 'audit',
        author: 'Admin Staff',
      ),
      TimelineEntry(
        id: '7',
        title: 'Appointment Scheduled',
        message:
            'Follow-up appointment scheduled for next week. Patient prefers morning time slots.',
        timestamp: now.subtract(const Duration(hours: 4)),
        type: 'note',
        author: 'Scheduler',
      ),
      TimelineEntry(
        id: '8',
        title: 'Prescription Sent',
        message:
            'New prescription for blood pressure medication sent to pharmacy. Patient notified via SMS.',
        timestamp: now.subtract(const Duration(hours: 5)),
        type: 'success',
        author: 'Dr. Smith',
      ),
      TimelineEntry(
        id: '9',
        title: 'Patient Education',
        message:
            'Provided educational materials about diabetes management and healthy lifestyle choices.',
        timestamp: now.subtract(const Duration(hours: 6)),
        type: 'note',
        author: 'Health Educator',
      ),
      TimelineEntry(
        id: '10',
        title: 'System Maintenance',
        message:
            'Scheduled system maintenance completed. All patient records have been backed up successfully.',
        timestamp: now.subtract(const Duration(hours: 8)),
        type: 'audit',
        author: 'IT Support',
      ),
      TimelineEntry(
        id: '11',
        title: 'Emergency Contact Updated',
        message:
            'Patient updated emergency contact information. New contact: Jane Doe (Spouse) - 555-0123.',
        timestamp: now.subtract(const Duration(hours: 12)),
        type: 'note',
        author: 'Patient',
      ),
      TimelineEntry(
        id: '12',
        title: 'Quality Assurance Review',
        message:
            'Monthly quality assurance review completed. All protocols followed correctly.',
        timestamp: now.subtract(const Duration(days: 1)),
        type: 'audit',
        author: 'QA Team',
      ),
    ];
  }
}
