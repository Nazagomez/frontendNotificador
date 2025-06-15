import 'package:flutter/material.dart';
import 'package:notificador/features/events/models/event_model.dart';
import 'package:notificador/features/events/utils/image_helper.dart';
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
    final imagePath = getCategoryImage(event.category);

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
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: _circleIconButton(
                  context,
                  icon: Icons.arrow_back,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: _circleIconButton(
                  context,
                  icon: Icons.share,
                  onPressed: () {},
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Organized by ${event.organizer}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.onSurface.withAlpha((0.6 * 255).toInt()),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: colors.shadow.withAlpha((0.5 * 255).toInt()),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
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
                        const SizedBox(height: 10),
                        _infoRow(
                          Icons.access_time,
                          'Time',
                          _formatTime(event.date),
                          colors,
                        ),
                        const SizedBox(height: 10),
                        _infoRow(
                          Icons.location_on,
                          'Location',
                          event.location,
                          colors,
                        ),
                        const SizedBox(height: 10),
                        _infoRow(
                          Icons.category,
                          'Category',
                          event.category,
                          colors,
                        ),
                        const SizedBox(height: 10),
                        _infoRow(
                          Icons.info_outline,
                          'State',
                          event.state,
                          colors,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  Text(
                    'Description',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.description,
                    style: textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),

                  const SizedBox(height: 30),

                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final authService = context.read<AuthService>();
                        if (!authService.isLoggedIn) {
                          Navigator.pushNamed(context, '/login');
                          return;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Attendance marked!')),
                        );
                      },
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Mark Attendance'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 14,
                        ),
                        backgroundColor: colors.primary,
                        foregroundColor: colors.onPrimary,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
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
        Icon(icon, size: 20, color: colors.primary),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: colors.onSurface.withAlpha((0.6 * 255).toInt()),
          ),
        ),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colors.onSurface.withAlpha((0.6 * 255).toInt()),
            ),
          ),
        ),
      ],
    );
  }

  Widget _circleIconButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    final colors = Theme.of(context).colorScheme;
    return CircleAvatar(
      backgroundColor: colors.surface.withAlpha((0.6 * 255).toInt()),
      child: IconButton(
        icon: Icon(icon, color: colors.primary),
        onPressed: onPressed,
      ),
    );
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
  String _formatTime(DateTime date) =>
      '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
}
