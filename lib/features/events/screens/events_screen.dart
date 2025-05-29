import 'package:flutter/material.dart';
import '../../events/services/eventServices.dart';
import '../../events/models/eventModels.dart';
import '../../events/screens/eventFormScreen.dart';
import '../../home/screens/homeScreen.dart';
import '../../user/screens/userProfileScreen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final EventService _eventService = EventService();
  List<EventModel> events = [];
  List<EventModel> filteredEvents = [];
  bool loading = true;
  int _selectedIndex = 1;
  String selectedCategory = 'Todo';

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    try {
      final fetchedEvents = await _eventService.fetchEvents();
      setState(() {
        events = fetchedEvents;
        filteredEvents = fetchedEvents;
        loading = false;
      });
    } catch (e) {
      print('Error fetching events: \$e');
      setState(() => loading = false);
    }
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'Todo') {
        filteredEvents = [...events];
      } else {
        filteredEvents = events.where((e) => e.categoria.toLowerCase() == category.toLowerCase()).toList();
      }
    });
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
        break;
      case 1:
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const UserProfileScreen()),
        );
        break;
      default:
        setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6C63FF);
    const backgroundColor = Color(0xFFF3F2F3);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text('Eventos', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar eventos',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: ['Todo', 'Deportes', 'Música', 'Arte', 'Tecnología'].map((text) {
                final isSelected = selectedCategory == text;
                return ChoiceChip(
                  label: Text(text),
                  selected: isSelected,
                  onSelected: (_) => filterByCategory(text),
                  selectedColor: primaryColor.withOpacity(0.2),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filteredEvents.length,
                      itemBuilder: (_, index) {
                        final event = filteredEvents[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/event-details');
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              children: [
                                event.imagen.isNotEmpty
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                        child: Image.network(
                                          event.imagen,
                                          height: 140,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        height: 140,
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[100],
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                        ),
                                        child: const Center(child: Icon(Icons.image)),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(event.fecha, style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 4),
                                      Text(event.titulo, style: const TextStyle(fontSize: 16)),
                                      Text(event.lugar),
                                      const SizedBox(height: 4),
                                      Text('${event.asistentes} asistentes'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EventFormScreen()),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Nuevo evento'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.event_note_outlined), label: 'Eventos'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notificaciones'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Mi perfil'),
        ],
      ),
    );
  }
}