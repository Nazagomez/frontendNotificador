import 'package:flutter/material.dart';
import 'package:notificador/shared/services/auth_service.dart';
import 'package:provider/provider.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  void _showDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(title),
            content: const Text('Feature coming soon!'),
          ),
    );
  }

  Future<void> _handleSignOut(BuildContext context) async {
    final authService = context.read<AuthService>();
    final navigator = Navigator.of(context);
    await authService.logout();
    navigator.maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Account', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ListTile(
            title: Text(
              'Change Password',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            leading: const Icon(Icons.lock_outline),
            onTap: () => _showDialog(context, 'Change Password'),
          ),
          ListTile(
            title: Text(
              'Sign Out',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            leading: const Icon(Icons.logout),
            onTap: () => _handleSignOut(context),
          ),
          ListTile(
            title: Text(
              'My Events',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            leading: const Icon(Icons.event_note),
            onTap: () => _showDialog(context, 'My Events'),
          ),
        ],
      ),
    );
  }
}
