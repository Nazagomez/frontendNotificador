import 'package:flutter/material.dart';
import 'package:notificador/features/auth/screens/loginScreen.dart';
import 'package:notificador/features/auth/screens/welcomeScreen.dart';
import 'package:notificador/features/auth/screens/events_screen.dart';
import 'package:notificador/features/auth/screens/event_detail_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const WelcomeScreen(),
  '/login': (context) => const LoginScreen(), // Placeholder for login screen
  '/events': (context) => const EventsScreen(),
  '/event-details': (context) => const EventDetailScreen(),
};
