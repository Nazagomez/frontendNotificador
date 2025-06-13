import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notificador/features/notifications/widgets/notification_detail_dialog.dart';
import 'package:notificador/shared/services/socket_service.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    final notifications = socketService.notifications;

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body:
          notifications.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : LayoutBuilder(
                builder: (context, constraints) {
                  final double itemHeight = constraints.maxHeight / 7;

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      final formattedDate = DateFormat(
                        'dd/MM/yyyy hh:mm a',
                      ).format(notification.createdAt);

                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder:
                                (_) => NotificationDetailDialog(
                                  title: notification.title,
                                  eventTitle: notification.eventTitle,
                                  message: notification.message,
                                  createdAt: notification.createdAt,
                                ),
                          );
                        },
                        child: Container(
                          height: itemHeight.clamp(145.0, 195.0),
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest
                                .withAlpha((0.8 * 255).toInt()),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(
                                  (0.05 * 255).toInt(),
                                ),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.notifications,
                                size: 32,
                                color: Colors.deepPurple,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notification.title,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      notification.eventTitle,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.labelMedium?.copyWith(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      notification.message,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      formattedDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
    );
  }
}
