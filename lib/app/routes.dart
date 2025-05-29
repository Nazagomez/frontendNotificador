import 'package:flutter/material.dart';
import 'package:notificador/features/auth/screens/loginScreen.dart';
import 'package:notificador/features/auth/screens/welcomeScreen.dart';
import 'package:notificador/features/events/screens/eventFormScreen.dart';
import 'package:notificador/features/user/screens/userProfileScreen.dart';



final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const WelcomeScreen(),
  '/login': (context) => const LoginScreen(), // Placeholder for login screen
  '/profile': (context) => const UserProfileScreen(),
  '/add-event': (context) => const EventFormScreen(),
};
