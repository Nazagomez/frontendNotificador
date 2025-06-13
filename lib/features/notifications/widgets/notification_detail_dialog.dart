import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationDetailDialog extends StatelessWidget {
  final String title;
  final String eventTitle;
  final String message;
  final DateTime createdAt;

  const NotificationDetailDialog({
    super.key,
    required this.title,
    required this.eventTitle,
    required this.message,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(createdAt);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: theme.colorScheme.surface,
      title: Row(
        children: [
          Icon(Icons.notifications, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildInfoItem(
            context,
            icon: Icons.event,
            label: 'Event',
            content: eventTitle,
          ),
          const Divider(height: 24),
          _buildInfoItem(
            context,
            icon: Icons.message,
            label: 'Message',
            content: message,
          ),
          const Divider(height: 24),
          _buildInfoItem(
            context,
            icon: Icons.access_time,
            label: 'Date',
            content: formattedDate,
          ),
        ],
      ),
      actions: [
        TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
          label: const Text('Close'),
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String content,
  }) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(content, style: theme.textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
