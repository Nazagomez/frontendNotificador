// lib/features/events/models/create_event_model.dart
class CreateEvent {
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String organizer;
  final int capacity;
  final String category;
  final bool featured;
  final String userId;

  CreateEvent({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.organizer,
    required this.capacity,
    required this.category,
    required this.featured,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date.toUtc().toIso8601String(),
      'location': location,
      'organizer': organizer,
      'capacity': capacity,
      'category': category,
      'featured': featured,
      'UserId': userId,
    };
  }
}
