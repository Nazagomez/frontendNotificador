import 'package:flutter/material.dart';

class NotificationSettingsSection extends StatefulWidget {
  const NotificationSettingsSection({super.key});

  @override
  State<NotificationSettingsSection> createState() =>
      _NotificationSettingsSectionState();
}

class _NotificationSettingsSectionState
    extends State<NotificationSettingsSection> {
  bool osNotifications = false;
  bool emailNotifications = false;
  bool eventReminders = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notification Settings',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SwitchListTile(
                    value: osNotifications,
                    onChanged: (value) {
                      setState(() {
                        osNotifications = value;
                      });
                    },
                    title: const Text('OS Notifications'),
                  ),
                  SwitchListTile(
                    value: emailNotifications,
                    onChanged: (value) {
                      setState(() {
                        emailNotifications = value;
                      });
                    },
                    title: const Text('Email Notifications'),
                  ),
                  SwitchListTile(
                    value: eventReminders,
                    onChanged: (value) {
                      setState(() {
                        eventReminders = value;
                      });
                    },
                    title: const Text('Event Reminders'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
