class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String organizer;
  final String category;
  final String state;
  final bool featured;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.organizer,
    required this.category,
    required this.state,
    required this.featured,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? '',
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      location: json['location'] ?? '',
      organizer: json['organizer'] ?? '',
      category: json['category'] ?? 'other',
      state: json['state'] ?? '',
      featured: json['featured'] ?? false,
    );
  }
}
