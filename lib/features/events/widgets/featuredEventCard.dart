import 'package:flutter/material.dart';
import '../models/eventModels.dart';

class FeaturedEventCard extends StatelessWidget {
  final EventModel event;

  const FeaturedEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 260,
      child: Card(
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            event.imagen.isNotEmpty
                ? Image.network(
                    event.imagen,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: const Color(0xFF9DA8C3),
                        child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.white, size: 40),
                        ),
                      );
                    },
                  )
                : Container(
                    height: 120,
                    width: double.infinity,
                    color: const Color(0xFF9DA8C3),
                    child: const Center(
                      child: Icon(Icons.image_outlined, size: 40, color: Colors.white),
                    ),
                  ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.titulo,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.event, size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(event.fecha, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.place, size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            event.lugar,
                            style: const TextStyle(color: Colors.grey, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.people, size: 16, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          '${event.asistentes} asistentes',
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
