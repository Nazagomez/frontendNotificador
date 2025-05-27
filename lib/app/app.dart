import 'package:flutter/material.dart';
import 'package:notificador/app/routes.dart';

class NotificadorApp extends StatelessWidget {
  const NotificadorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notificador UNA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
