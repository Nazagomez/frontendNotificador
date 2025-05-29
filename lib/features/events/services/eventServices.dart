import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/eventModels.dart';

class EventService {
  final String _baseUrl = 'http://10.0.2.2:3000/api';

  Future<List<EventModel>> fetchEvents() async {
    final url = Uri.parse('$_baseUrl/eventos');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => EventModel.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar eventos');
    }
  }
}
