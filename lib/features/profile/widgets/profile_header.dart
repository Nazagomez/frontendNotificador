import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;

  const ProfileHeader({required this.name, required this.email, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/image-not-found.png'),
          ),
          const SizedBox(height: 12),
          Text(name, style: Theme.of(context).textTheme.headlineSmall),
          Text(email, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
