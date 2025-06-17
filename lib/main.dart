import 'package:flutter/material.dart';
import 'package:notificador/core/routes/app_routes.dart';
import 'package:notificador/core/theme/app_theme.dart';
import 'package:notificador/features/main_layout/main_layout.dart';
import 'package:notificador/shared/services/auth_service.dart';
import 'package:notificador/shared/services/notification_service.dart';
import 'package:notificador/shared/services/permissions_service.dart';
import 'package:notificador/shared/services/socket_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestNotificationPermission();

  await OSNotificationService().initNotification();

  final authService = AuthService();
  await authService.loadUser();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService()..connect()),
        ChangeNotifierProvider<AuthService>.value(value: authService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {'/': (_) => const MainLayout(), ...AppRoutes.routes},
    );
  }
}
