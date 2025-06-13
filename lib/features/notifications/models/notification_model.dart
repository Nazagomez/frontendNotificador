class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String eventTitle;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.eventTitle,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? 'no-id',
      title: json['title'] ?? 'No Title',
      message: json['message'] ?? 'No Message',
      eventTitle: json['eventTitle'] ?? 'No Event Title',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}
