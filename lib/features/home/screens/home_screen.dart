import 'package:flutter/material.dart';
import 'package:notificador/features/events/services/event_service.dart';
import 'package:notificador/features/events/widgets/event_card_medium.dart';
import 'package:notificador/features/events/widgets/event_card_small.dart';
import '../../events/models/event_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<Map<String, List<Event>>> _getFilteredEvents() {
    return EventService.fetchFilteredEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Map<String, List<Event>>>(
        future: _getFilteredEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No events found'));
          }

          final featuredEvents = snapshot.data!['featured']!;
          final upcomingEvents = snapshot.data!['upcoming']!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título Featured Events
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Featured Events',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              // Sección Featured
              SizedBox(
                height:
                    MediaQuery.of(context).size.height * 0.25 -
                    kBottomNavigationBarHeight,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        featuredEvents.map((event) {
                          return Flexible(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 380),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: SmallEventCard(event: event),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),

              // Título Upcoming
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                child: Text(
                  'Upcoming Events',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              // Sección Upcoming
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        upcomingEvents.map((event) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 380,
                                  child: MediumEventCard(event: event),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
