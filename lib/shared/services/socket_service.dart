// lib/shared/services/socket_service.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notificador/core/constants/api_constants.dart';
import 'package:notificador/features/notifications/services/notification_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:notificador/features/notifications/models/notification_model.dart';

class SocketService with ChangeNotifier {
  late io.Socket _socket;
  final List<NotificationModel> _notifications = [];
  int _unreadCount = 0;

  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _unreadCount;

  void connect() {
    _socket = io.io(ApiConstants.url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();

    _socket.onConnect((_) {
      debugPrint('✅ Socket connected');
    });

    _socket.on('notification', (data) {
      debugPrint('🔔 Notification received');

      debugPrint(jsonEncode(data));
      final notify = NotificationModel.fromJson(
        Map<String, dynamic>.from(data),
      );
      _notifications.insert(0, notify);
      _unreadCount++;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      debugPrint('❌ Socket disconnected');
    });

    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      debugPrint('📥 Fetching notifications from server begins');
      final notifications = await NotificationService.fetchNotifications();
      debugPrint('📥 Fetching notifications from server completed');
      _notifications.clear();
      _notifications.addAll(notifications);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading notifications: $e');
    }
  }

  void resetUnreadCount() {
    _unreadCount = 0;
    notifyListeners();
  }

  void disconnect() {
    _socket.disconnect();
  }
}
