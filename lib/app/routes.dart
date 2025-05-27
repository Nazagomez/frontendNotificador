import 'package:flutter/material.dart';
import 'package:notificador/features/auth/screens/loginScreen.dart';
import 'package:notificador/features/auth/screens/welcomeScreen.dart';


final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const WelcomeScreen(),
  '/login': (context) => const LoginScreen(), // Placeholder for login screen
};
