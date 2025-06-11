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

          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Featured Events',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: featuredEvents.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 180,
                      child: SmallEventCard(event: featuredEvents[index]),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Upcoming Events',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: upcomingEvents.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 200,
                    child: MediumEventCard(event: upcomingEvents[index]),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
