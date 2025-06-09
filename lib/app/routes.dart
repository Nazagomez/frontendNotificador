import 'package:flutter/material.dart';
import 'package:notificador/features/auth/screens/loginScreen.dart';
import 'package:notificador/features/auth/screens/welcomeScreen.dart';
import 'package:notificador/features/events/screens/eventFormScreen.dart';
import 'package:notificador/features/events/screens/event_detail_screen.dart';
import 'package:notificador/features/events/screens/events_screen.dart';
import 'package:notificador/features/user/screens/userProfileScreen.dart';
import 'package:notificador/app/mainScreen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const WelcomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/home': (context) => const MainScreen(),
  '/profile': (context) => const UserProfileScreen(),
  '/events': (context) => const EventsScreen(),         // Lista de eventos
  '/event-details': (context) => const EventDetailScreen(), // Detalle de un evento
  '/add-event': (context) => const EventFormScreen(),
};