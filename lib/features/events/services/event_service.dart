import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notificador/features/events/models/create_event_model.dart';
import 'package:notificador/features/events/models/update_event_model.dart';
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

    return {'featured': featured, 'upcoming': upcoming.take(4).toList()};
  }

  static Future<Event> createEvent(CreateEvent event) async {
    final uri = Uri.parse(eventsUrl);

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(event.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Event.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create event: ${response.body}');
    }
  }

  static Future<Event> updateEvent(String id, UpdateEvent updatedEvent) async {
    final uri = Uri.parse('$eventsUrl/$id');

    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(updatedEvent.toJson()),
    );

    if (response.statusCode == 200) {
      return Event.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update event: ${response.body}');
    }
  }

  static Future<void> registerAttendance(String id, String userId) async {
    final uri = Uri.parse('$eventsUrl/$id/$userId');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register attendance');
    }
    return;
  }

  static Future<void> cancelAttendance(String id, String userId) async {
    final uri = Uri.parse('$eventsUrl/$id/$userId');

    final response = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to cancel attendance');
    }
    return;
  }

  static Future<bool> hasUserRegisteredAttendance(
    String id,
    String userId,
  ) async {
    final uri = Uri.parse('$eventsUrl/$id/attendance/$userId');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['attending'] == true;
    } else {
      throw Exception('Failed to check attendance: ${response.body}');
    }
  }
}
