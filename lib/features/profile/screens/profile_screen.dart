import 'package:flutter/material.dart';
import 'package:notificador/features/profile/widgets/account_section.dart';
import 'package:notificador/features/profile/widgets/notification_settings_section.dart';
import 'package:notificador/features/profile/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;

          return Column(
            children: [
              // Top 35%: Profile Header
              SizedBox(
                height: height * 0.35,
                child: ProfileHeader(
                  name: 'User Name',
                  email: 'user@email.com',
                ),
              ),

              // Bottom 65% split in two parts
              SizedBox(
                height: height * 0.65,
                child: Column(
                  children: const [
                    // NotificationSettings: 25% of total height
                    Expanded(child: NotificationSettingsSection()),

                    // AccountSection: 25% of total height
                    Expanded(child: AccountSection()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
