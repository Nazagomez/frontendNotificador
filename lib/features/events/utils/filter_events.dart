import 'package:notificador/features/events/models/event_model.dart';

List<Event> filterEvents(
  List<Event> events, {
  required String query,
  required String category,
  required String? state,
  required DateTime? startDate,
  required DateTime? endDate,
}) {
  final lowerQuery = query.toLowerCase();

  return events.where((event) {
    final matchesQuery = event.title.toLowerCase().contains(lowerQuery);
    final matchesCategory = category == 'all' || event.category == category;
    final matchesState =
        state == null || state == 'all' || event.state == state;

    final matchesDateRange =
        (startDate == null && endDate == null) ||
        (startDate != null &&
            endDate == null &&
            event.date.isAfter(startDate.subtract(const Duration(days: 1)))) ||
        (startDate == null &&
            endDate != null &&
            event.date.isBefore(endDate.add(const Duration(days: 1)))) ||
        (startDate != null &&
            endDate != null &&
            event.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
            event.date.isBefore(endDate.add(const Duration(days: 1))));

    return matchesQuery && matchesCategory && matchesState && matchesDateRange;
  }).toList();
}
