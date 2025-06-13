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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: FutureBuilder<Map<String, List<Event>>>(
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
                  const Text(
                    'Featured Events',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Featured events - centradas y sin scroll horizontal
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          featuredEvents.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: SizedBox(
                              width: 160,
                              child: SmallEventCard(
                                event: featuredEvents[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Upcoming Events',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Upcoming events - scroll vertical natural
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: upcomingEvents.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 200,
                          child: MediumEventCard(event: upcomingEvents[index]),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
