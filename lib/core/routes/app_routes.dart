import 'package:flutter/material.dart';
import 'package:notificador/core/routes/auth_guard.dart';
import 'package:notificador/features/events/screens/events_screen.dart';
import 'package:notificador/features/home/screens/home_screen.dart';
import 'package:notificador/features/notifications/screens/notifications_screen.dart';
import 'package:notificador/features/profile/screens/login_screen.dart';
import 'package:notificador/features/profile/screens/profile_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String events = '/events';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
  static const String login = '/login';

  static final Map<String, WidgetBuilder> routes = {
    home: (_) => const HomeScreen(),
    events: (_) => const EventsScreen(),
    notifications: (_) => const NotificationsScreen(),
    profile: (_) => AuthGuard(builder: (context) => ProfileScreen()),
    login: (_) => const LoginScreen(),
  };
}
