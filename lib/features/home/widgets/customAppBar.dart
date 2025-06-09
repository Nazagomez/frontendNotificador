import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6C63FF);

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE1E4ED),
            ),
            padding: const EdgeInsets.all(8),
            child: const Icon(Icons.notifications, color: primaryColor),
          ),
          const SizedBox(width: 12),
          const Text(
            'UNAvoz',
            style: TextStyle(
              color: primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}