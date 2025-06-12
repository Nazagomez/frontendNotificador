import 'package:flutter/material.dart';
import 'package:notificador/core/constants/event_categories.dart';
import 'package:notificador/features/events/dialogs/event_filter_dialog.dart';

class EventsFilterBar extends StatelessWidget {
  final String searchQuery;
  final String selectedCategory;
  final DateTime? selectedStartDate;
  final DateTime? selectedEndDate;
  final String? selectedState;

  final ValueChanged<String> onQueryChanged;
  final ValueChanged<EventFilter> onFilterChanged;

  const EventsFilterBar({
    super.key,
    required this.searchQuery,
    required this.selectedCategory,
    required this.selectedStartDate,
    required this.selectedEndDate,
    required this.selectedState,
    required this.onQueryChanged,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: onQueryChanged,
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
                final result = await showDialog<EventFilter>(
                  context: context,
                  builder:
                      (_) => EventFilterDialog(
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

                if (result != null) onFilterChanged(result);
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
                  onSelected:
                      (_) => onFilterChanged(
                        EventFilter(
                          category: cat == 'all' ? null : cat,
                          startDate: selectedStartDate,
                          endDate: selectedEndDate,
                          state: selectedState,
                        ),
                      ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
