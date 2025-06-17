import 'package:flutter/material.dart';
import 'package:notificador/features/events/dialogs/edit_event_dialog.dart';
import 'package:notificador/features/events/models/event_model.dart';
import 'package:notificador/features/events/services/event_service.dart';
import 'package:notificador/features/events/utils/image_helper.dart';
import 'package:notificador/shared/services/auth_service.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool isAttending = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAttendance();
  }

  Future<void> _checkAttendance() async {
    final authService = context.read<AuthService>();
    if (!authService.isLoggedIn) return;

    final userId = authService.currentUser?.id;

    try {
      if (userId == null) {
        setState(() => isLoading = false);
        return;
      }
      final attending = await EventService.hasUserRegisteredAttendance(
        widget.event.id,
        userId,
      );
      if (mounted) {
        setState(() {
          isAttending = attending;
          isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _toggleAttendance() async {
    final authService = context.read<AuthService>();
    if (!authService.isLoggedIn) {
      Navigator.pushNamed(context, '/login');
      return;
    }

    final userId = authService.currentUser?.id;

    try {
      setState(() => isLoading = true);

      if (userId == null) {
        setState(() => isLoading = false);
        return;
      }

      if (isAttending) {
        await EventService.cancelAttendance(widget.event.id, userId);
      } else {
        await EventService.registerAttendance(widget.event.id, userId);
      }

      if (mounted) {
        setState(() {
          isAttending = !isAttending;
          isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;
    final imagePath = getCategoryImage(event.category);
    final isAdmin = context.watch<AuthService>().isAdmin;

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
                        const SizedBox(height: 10),
                        _infoRow(
                          Icons.numbers,
                          'Event Capacity',
                          event.capacity.toString(),
                          colors,
                        ),
                        const SizedBox(height: 10),
                        _infoRow(
                          Icons.people_outline,
                          'Attendees',
                          event.attendeesCount.toString(),
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
                    child:
                        isLoading
                            ? const CircularProgressIndicator()
                            : ElevatedButton.icon(
                              onPressed: _toggleAttendance,
                              icon: Icon(
                                isAttending
                                    ? Icons.cancel
                                    : Icons.check_circle_outline,
                              ),
                              label: Text(
                                isAttending
                                    ? 'Cancel Attendance'
                                    : 'Mark Attendance',
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 14,
                                ),
                                backgroundColor: colors.primary,
                                foregroundColor: colors.onPrimary,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
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
      floatingActionButton:
          isAdmin
              ? Transform.translate(
                offset: const Offset(0, -12),
                child: FloatingActionButton(
                  onPressed: () async {
                    final updated = await showDialog<bool>(
                      context: context,
                      builder: (_) => EditEventDialog(event: event),
                    );
                    if (updated == true && context.mounted) {
                      Navigator.of(context).pop(true);
                    }
                  },
                  backgroundColor: colors.primary,
                  child: const Icon(Icons.edit),
                ),
              )
              : null,
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
