import 'package:flutter/material.dart';
import 'package:notificador/features/events/models/event_model.dart';

class SmallEventCard extends StatelessWidget {
  final Event event;

  const SmallEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // Cuadrada
      child: Card(
        child: Column(
          children: [
            // Imagen ocupa 2/5
            Expanded(
              flex: 2,
              child: Image.asset(
                'assets/images/image-not-found.png',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            // Texto ocupa 3/5
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  event.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
