import 'package:flutter/material.dart';
import 'package:notificador/core/constants/event_categories.dart';
import 'package:notificador/features/events/dialogs/event_filter_dialog.dart';
import 'package:notificador/features/events/screens/event_details_screen.dart';
import 'package:notificador/features/events/widgets/event_card_medium.dart';
import 'package:notificador/features/events/models/event_model.dart';
import 'package:notificador/features/events/services/event_service.dart';

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

  List<Event> getFilteredEvents() {
    final query = searchQuery.toLowerCase();

    return allEvents.where((event) {
      final matchesQuery = event.title.toLowerCase().contains(query);

      final matchesCategory =
          selectedCategory == 'all' || event.category == selectedCategory;

      final matchesState =
          selectedState == null ||
          selectedState == 'all' ||
          event.state == selectedState;

      final matchesDateRange =
          (selectedStartDate == null && selectedEndDate == null) ||
          (selectedStartDate != null &&
              selectedEndDate == null &&
              event.date.isAfter(
                selectedStartDate!.subtract(const Duration(days: 1)),
              )) ||
          (selectedStartDate == null &&
              selectedEndDate != null &&
              event.date.isBefore(
                selectedEndDate!.add(const Duration(days: 1)),
              )) ||
          (selectedStartDate != null &&
              selectedEndDate != null &&
              event.date.isAfter(
                selectedStartDate!.subtract(const Duration(days: 1)),
              ) &&
              event.date.isBefore(
                selectedEndDate!.add(const Duration(days: 1)),
              ));

      return matchesQuery &&
          matchesCategory &&
          matchesState &&
          matchesDateRange;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredEvents = getFilteredEvents();

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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => setState(() => searchQuery = value),
                    decoration: InputDecoration(
                      hintText: 'Search events...',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: Icon(
                    Icons.filter_list,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () async {
                    final filterResult = await showDialog<EventFilter>(
                      context: context,
                      builder:
                          (context) => EventFilterDialog(
                            categories: eventCategories,
                            initialFilter: EventFilter(
                              category:
                                  selectedCategory != 'all'
                                      ? selectedCategory
                                      : null,
                              startDate: selectedStartDate,
                              endDate: selectedEndDate,
                              state: selectedState,
                            ),
                          ),
                    );

                    if (filterResult != null) {
                      setState(() {
                        selectedCategory = filterResult.category ?? 'all';
                        selectedStartDate = filterResult.startDate;
                        selectedEndDate = filterResult.endDate;
                        selectedState = filterResult.state ?? 'all';
                      });
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: eventCategories.length,
                itemBuilder: (context, index) {
                  final cat = eventCategories[index];
                  final isSelected = cat == selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      labelStyle: TextStyle(
                        color:
                            isSelected
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                      onSelected: (_) => setState(() => selectedCategory = cat),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Builder(
                builder: (context) {
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
                  if (filteredEvents.isEmpty) {
                    return Center(
                      child: Text(
                        'No events found',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: filteredEvents.length + (isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == filteredEvents.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final event = filteredEvents[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        EventDetailsScreen(event: event),
                              ),
                            );
                          },
                          child: MediumEventCard(event: event),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
