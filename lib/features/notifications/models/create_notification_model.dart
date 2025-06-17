class CreateNotification {
  final String title;
  final String message;
  final String userId;
  final String eventId;

  CreateNotification({
    required this.title,
    required this.message,
    required this.userId,
    required this.eventId,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'UserId': userId,
      'EventId': eventId,
    };
  }

  factory CreateNotification.fromJson(Map<String, dynamic> json) {
    return CreateNotification(
      title: json['title'],
      message: json['message'],
      userId: json['UserId'],
      eventId: json['EventId'],
    );
  }
}
