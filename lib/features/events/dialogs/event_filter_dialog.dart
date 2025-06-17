import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventFilter {
  final String? category;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? state;

  EventFilter({this.category, this.startDate, this.endDate, this.state});
}

class EventFilterDialog extends StatefulWidget {
  final List<String> categories;
  final EventFilter? initialFilter;

  const EventFilterDialog({
    super.key,
    required this.categories,
    this.initialFilter,
  });

  @override
  State<EventFilterDialog> createState() => _EventFilterDialogState();
}

class _EventFilterDialogState extends State<EventFilterDialog> {
  String? selectedCategory;
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  String? selectedState;

  final List<String> states = [
    'upcoming',
    'ongoing',
    'completed',
    'cancelled',
    'postponed',
  ];

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialFilter?.category;
    selectedStartDate = widget.initialFilter?.startDate;
    selectedEndDate = widget.initialFilter?.endDate;
    selectedState = widget.initialFilter?.state;
  }

  Future<void> _pickStartDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (!mounted) return;

    if (date != null) {
      setState(() {
        selectedStartDate = date;
      });
    }
  }

  Future<void> _pickEndDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedEndDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (!mounted) return;

    if (date != null) {
      setState(() {
        selectedEndDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Events'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category
            const Text('Categories'),
            const SizedBox(height: 4),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              isExpanded: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items:
                  widget.categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
              onChanged: (value) => setState(() => selectedCategory = value),
            ),
            const SizedBox(height: 16),
            // Date and Time
            const Text('Start Date'),
            const SizedBox(height: 4),
            InkWell(
              onTap: _pickStartDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select start date',
                ),
                child: Text(
                  selectedStartDate != null
                      ? DateFormat('yyyy-MM-dd').format(selectedStartDate!)
                      : 'No date selected',
                ),
              ),
            ),
            const SizedBox(height: 12),

            const Text('End Date'),
            const SizedBox(height: 4),
            InkWell(
              onTap: _pickEndDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Select end date',
                ),
                child: Text(
                  selectedEndDate != null
                      ? DateFormat('yyyy-MM-dd').format(selectedEndDate!)
                      : 'No date selected',
                ),
              ),
            ),

            // State
            const Text('State'),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children:
                  states.map((state) {
                    final bool isSelected = selectedState == state;
                    return ChoiceChip(
                      label: Text(state),
                      selected: isSelected,
                      onSelected: (_) => setState(() => selectedState = state),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final result = EventFilter(
              category: selectedCategory,
              startDate: selectedStartDate,
              endDate: selectedEndDate,
              state: selectedState,
            );
            Navigator.of(context).pop(result);
          },
          child: const Text('Apply Filters'),
        ),
      ],
    );
  }
}
