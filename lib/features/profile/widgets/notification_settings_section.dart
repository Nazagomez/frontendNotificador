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
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Notification Settings',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            value: osNotifications,
            onChanged: (value) {
              setState(() {
                osNotifications = value;
              });
            },
            secondary: const Icon(
              Icons.notifications_active_outlined,
            ), // OS Notifications
            title: Text(
              'OS Notifications',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),

          SwitchListTile(
            value: emailNotifications,
            onChanged: (value) {
              setState(() {
                emailNotifications = value;
              });
            },
            secondary: const Icon(Icons.email_outlined),
            title: Text(
              'Email Notifications',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),

          SwitchListTile(
            value: eventReminders,
            onChanged: (value) {
              setState(() {
                eventReminders = value;
              });
            },
            secondary: const Icon(Icons.event_note_outlined),
            title: Text(
              'Event Reminders',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
