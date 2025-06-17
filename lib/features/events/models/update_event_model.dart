class UpdateEvent {
  final String? title;
  final String? description;
  final DateTime? date;
  final String? location;
  final String? organizer;
  final int? capacity;
  final String? category;
  final String? state;
  final bool? featured;

  UpdateEvent({
    this.title,
    this.description,
    this.date,
    this.location,
    this.organizer,
    this.capacity,
    this.category,
    this.state,
    this.featured,
  });

  Map<String, dynamic> toJson() {
    return {
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (date != null) 'date': date!.toIso8601String(),
      if (location != null) 'location': location,
      if (organizer != null) 'organizer': organizer,
      if (category != null) 'category': category,
      if (category != null) 'capacity': capacity,
      if (state != null) 'state': state,
      if (featured != null) 'featured': featured,
    };
  }
}
