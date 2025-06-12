import 'package:flutter/material.dart';
import 'package:notificador/features/events/models/event_model.dart';
import 'package:notificador/features/events/screens/event_details_screen.dart';
import 'package:notificador/features/events/widgets/event_card_medium.dart';

class EventsList extends StatelessWidget {
  final ScrollController scrollController;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final List<Event> events;

  const EventsList({
    super.key,
    required this.scrollController,
    required this.isLoading,
    required this.isLoadingMore,
    required this.errorMessage,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Text(
          errorMessage!,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      );
    }

    if (events.isEmpty) {
      return Center(
        child: Text(
          'No events found',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: events.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == events.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final event = events[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EventDetailsScreen(event: event),
                ),
              );
            },
            child: MediumEventCard(event: event),
          ),
        );
      },
    );
  }
}
