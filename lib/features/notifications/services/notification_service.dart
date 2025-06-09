import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notificador/core/constants/api_constants.dart';
import '../models/notification_model.dart';

class NotificationService {
  static final String notificationsUrl =
      '${ApiConstants.baseUrl}/notifications';

  static Future<List<NotificationModel>> fetchNotifications() async {
    final response = await http.get(Uri.parse(notificationsUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      if (jsonList.isEmpty) {
        return [];
      }
      return jsonList.map((json) => NotificationModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch notifications');
    }
  }
}
