import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/providers/authProvider.dart';
import 'app/app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const NotificadorApp(),
    ),
  );
}



