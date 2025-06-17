import 'package:flutter/material.dart';
import 'package:notificador/features/notifications/models/create_notification_model.dart';
import 'package:notificador/features/notifications/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:notificador/shared/services/auth_service.dart';

class AddNotificationDialog extends StatefulWidget {
  final String eventId;
  const AddNotificationDialog({super.key, required this.eventId});

  @override
  State<AddNotificationDialog> createState() => _AddNotificationDialogState();
}

class _AddNotificationDialogState extends State<AddNotificationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final authService = context.read<AuthService>();
    final userId = authService.currentUser?.id;

    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No user logged in')));
      return;
    }

    final newNotification = CreateNotification(
      title: _titleController.text,
      message: _messageController.text,
      userId: userId,
      eventId: widget.eventId,
    );

    setState(() => _isSubmitting = true);

    try {
      await NotificationService.createNotification(newNotification);
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(
        'Send Notification',
        style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(_titleController, 'Title', required: true),
              _buildTextField(_messageController, 'Message', required: true),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(foregroundColor: colorScheme.error),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submit,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child:
              _isSubmitting
                  ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Text('Send'),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool required = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: colorScheme.onSurface),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.outline),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        validator:
            required
                ? (v) => (v == null || v.isEmpty) ? 'Required' : null
                : null,
      ),
    );
  }
}
