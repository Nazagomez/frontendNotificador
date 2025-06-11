import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Account', style: Theme.of(context).textTheme.titleMedium),
          TextButton(
            onPressed: () => _showDialog(context, 'Change Password'),
            child: const Text('Change Password'),
          ),
          TextButton(
            onPressed: () => _showDialog(context, 'Sign Out'),
            child: const Text('Sign Out'),
          ),
          TextButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/my-events');
            },
            child: const Text('My Events'),
          ),
        ],
      ),
    );
  }
}
