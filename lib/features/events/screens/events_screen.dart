import 'package:flutter/material.dart';
import 'package:notificador/features/events/dialogs/add_event_dialog.dart';
import 'package:notificador/features/events/screens/event_details_screen.dart';
import 'package:notificador/features/events/utils/filter_events.dart';
import 'package:notificador/features/events/models/event_model.dart';
import 'package:notificador/features/events/services/event_service.dart';
import 'package:notificador/features/events/widgets/events_filter_bar.dart';
import 'package:notificador/features/events/widgets/events_list.dart';
import 'package:notificador/shared/services/auth_service.dart';
import 'package:provider/provider.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<Event> allEvents = [];
  String searchQuery = '';
  String selectedCategory = 'all';
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String? selectedState;

  bool isLoading = false;
  bool isLoadingMore = false;
  bool hasMore = true;
  String? errorMessage;

  final int pageSize = 20;
  int page = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadEvents();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreEvents();
      }
    });
  }

  Future<void> _loadEvents() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      page = 0;
      hasMore = true;
    });

    try {
      final events = await EventService.fetchEvents(page: page, size: pageSize);
      setState(() {
        allEvents = events;
        page = 1;
        hasMore = events.length == pageSize;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading events: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadMoreEvents() async {
    if (isLoadingMore || !hasMore) return;

    setState(() {
      isLoadingMore = true;
      errorMessage = null;
    });

    try {
      final events = await EventService.fetchEvents(page: page, size: pageSize);
      setState(() {
        allEvents.addAll(events);
        page++;
        hasMore = events.length == pageSize;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading more events: $e';
      });
    } finally {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();
    final isAdmin = authService.isAdmin;

    final filteredEvents = filterEvents(
      allEvents,
      query: searchQuery,
      category: selectedCategory,
      state: selectedState,
      startDate: selectedStartDate,
      endDate: selectedEndDate,
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Events'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EventsFilterBar(
              searchQuery: searchQuery,
              selectedCategory: selectedCategory,
              selectedStartDate: selectedStartDate,
              selectedEndDate: selectedEndDate,
              selectedState: selectedState,
              onQueryChanged: (v) => setState(() => searchQuery = v),
              onFilterChanged: (filter) {
                setState(() {
                  selectedCategory = filter.category ?? 'all';
                  selectedStartDate = filter.startDate;
                  selectedEndDate = filter.endDate;
                  selectedState = filter.state ?? 'all';
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: EventsList(
                scrollController: _scrollController,
                isLoading: isLoading,
                isLoadingMore: isLoadingMore,
                errorMessage: errorMessage,
                events: filteredEvents,
                onEventTap: (event) async {
                  final updated = await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EventDetailsScreen(event: event),
                    ),
                  );

                  if (updated == true) {
                    _loadEvents();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          isAdmin
              ? Transform.translate(
                offset: const Offset(0, -12),
                child: FloatingActionButton(
                  onPressed: () async {
                    final created = await showDialog<bool>(
                      context: context,
                      builder: (_) => const AddEventDialog(),
                    );

                    if (created == true) {
                      _loadEvents();
                    }
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Icon(Icons.add),
                ),
              )
              : null,
    );
  }
}
