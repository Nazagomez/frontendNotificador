import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../core/constants/api_constants.dart';
import '../models/event_model.dart';

class EventService {
  static final String eventsUrl = '${ApiConstants.baseUrl}/events';

  static Future<List<Event>> fetchEvents({int page = 0, int size = 20}) async {
    final uri = Uri.parse('$eventsUrl?page=$page&size=$size');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      if (jsonList.isEmpty) {
        return [];
      }
      return jsonList.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  }

  static Future<Map<String, List<Event>>> fetchFilteredEvents() async {
    final allEvents = await fetchEvents();

    final featured = allEvents.where((e) => e.featured).take(2).toList();
    final upcoming =
        allEvents
            .where((e) => !e.featured && e.date.isAfter(DateTime.now()))
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));

    return {'featured': featured, 'upcoming': upcoming.take(2).toList()};
  }
}
