import 'package:flutter/material.dart';
import 'package:notificador/features/events/models/event_model.dart';
import 'package:notificador/shared/services/auth_service.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('assets/images/image-not-found.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: colors.onSurface.withValues(alpha: 0.6),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: colors.surface),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: CircleAvatar(
                  backgroundColor: colors.onSurface.withValues(alpha: 0.6),
                  child: IconButton(
                    icon: Icon(Icons.share, color: colors.surface),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Organizer ${event.organizer}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: colors.shadow.withValues(alpha: 0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _infoRow(
                          Icons.calendar_today,
                          'Date',
                          _formatDate(event.date),
                          colors,
                        ),
                        const SizedBox(height: 8),
                        _infoRow(
                          Icons.access_time,
                          'Hour',
                          _formatTime(event.date),
                          colors,
                        ),
                        const SizedBox(height: 8),
                        _infoRow(
                          Icons.location_on,
                          'Location',
                          event.location,
                          colors,
                        ),
                        const SizedBox(height: 8),
                        _infoRow(
                          Icons.category,
                          'Category',
                          event.category,
                          colors,
                        ),
                        const SizedBox(height: 8),
                        _infoRow(
                          Icons.info_outline,
                          'State',
                          event.state,
                          colors,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final authService = context.read<AuthService>();
                        final isLoggedIn = authService.isLoggedIn;

                        if (!isLoggedIn) {
                          Navigator.pushNamed(context, '/login');
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Attendance marked!')),
                        );
                      },
                      icon: const Icon(Icons.check_circle),
                      label: const Text('Mark Attendance'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),

                  Text(
                    'Description',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.description,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    String value,
    ColorScheme colors,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: colors.onSurfaceVariant),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colors.onSurfaceVariant,
          ),
        ),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: colors.onSurfaceVariant),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
