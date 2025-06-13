import 'package:flutter/material.dart';
import 'package:notificador/features/profile/screens/login_screen.dart';
import 'package:notificador/shared/services/auth_service.dart';
import 'package:provider/provider.dart';

class AuthGuard extends StatelessWidget {
  final WidgetBuilder builder;
  final bool requireAdmin;

  const AuthGuard({
    super.key,
    required this.builder,
    this.requireAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    final isLoggedIn = authService.isLoggedIn;
    final isAdmin = authService.isAdmin;

    if (!isLoggedIn || (requireAdmin && !isAdmin)) {
      return const LoginScreen();
    }

    debugPrint('AuthGuard: User is logged in: $isLoggedIn, isAdmin: $isAdmin');

    return builder(context);
  }
}
