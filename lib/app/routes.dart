import 'package:flutter/material.dart';
import 'package:notificador/features/auth/screens/loginScreen.dart';
import 'package:notificador/features/auth/screens/welcomeScreen.dart';
//current change
import 'package:notificador/features/home/screens/homeScreen.dart';

//incoming change
import 'package:notificador/features/events/screens/eventFormScreen.dart';
import 'package:notificador/features/user/screens/userProfileScreen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const WelcomeScreen(),
  //current change
  // '/login': (context) => const LoginScreen(),
  '/home': (context) => const HomeScreen(), // Placeholder for login screen

//incoming change
  '/login': (context) => const LoginScreen(), // Placeholder for login screen
  '/profile': (context) => const UserProfileScreen(),
  '/events': (context) => const EventsScreen(),
  '/event-details': (context) => const EventDetailScreen(),
  '/add-event': (context) => const EventFormScreen(),
};