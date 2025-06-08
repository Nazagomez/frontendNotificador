import 'package:flutter/material.dart';
import 'package:notificador/features/events/models/event_model.dart';
import 'package:notificador/features/events/widgets/event_card_medium.dart';
import 'package:notificador/features/events/widgets/event_card_small.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Simulación de eventos
  List<Event> get sampleEvents => [
    Event(
      id: '1',
      title: 'Tech Expo 2025',
      description: 'Evento de tecnología.',
      date: DateTime.now().add(const Duration(days: 2)),
      location: 'Auditorio UNA',
      organizer: 'UNA',
      category: 'technology',
      state: 'upcoming',
      featured: true,
    ),
    Event(
      id: '2',
      title: 'Feria Cultural',
      description: 'Evento de arte y cultura.',
      date: DateTime.now().add(const Duration(days: 4)),
      location: 'Plaza Central',
      organizer: 'UNA',
      category: 'culture',
      state: 'upcoming',
      featured: true,
    ),
    Event(
      id: '3',
      title: 'Torneo de Fútbol',
      description: 'Competencia deportiva',
      date: DateTime.now().add(const Duration(days: 1)),
      location: 'Cancha principal',
      organizer: 'UNA',
      category: 'sport',
      state: 'upcoming',
      featured: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final featured = sampleEvents.where((e) => e.featured).toList();
    final upcoming =
        sampleEvents.where((e) => e.state == 'upcoming').toList()
          ..sort((a, b) => a.date.compareTo(b.date));

    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Featured Events',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: featured.length.clamp(0, 2),
                      itemBuilder:
                          (context, index) =>
                              EventCardSmall(event: featured[index]),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.75 - MediaQuery.of(context).padding.top,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Text(
                      'Upcoming Events',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: upcoming.length.clamp(0, 2),
                      itemBuilder:
                          (context, index) =>
                              EventCardMedium(event: upcoming[index]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
