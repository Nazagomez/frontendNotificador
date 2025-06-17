import 'package:flutter/material.dart';
import 'package:notificador/features/profile/widgets/account_section.dart';
import 'package:notificador/features/profile/widgets/notification_settings_section.dart';
import 'package:notificador/features/profile/widgets/profile_header.dart';
import 'package:notificador/shared/services/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                flex: 3,
                child: ProfileHeader(
                  name:
                      '${authService.currentUser?.name ?? 'guest'} ${authService.currentUser?.lastName ?? 'guest'}',
                  email: authService.currentUser?.email ?? 'unknown@email.com',
                ),
              ),
              Expanded(
                flex: 7,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight * 0.7,
                    ),
                    child: Column(
                      children: const [
                        NotificationSettingsSection(),
                        AccountSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
