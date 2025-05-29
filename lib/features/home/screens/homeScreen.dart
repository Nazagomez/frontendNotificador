import 'package:flutter/material.dart';
import '../../events/models/eventModels.dart';
import '../../events/services/eventServices.dart';
import '../widgets/featuredEventCard.dart';
import '../widgets/upcomingEventCard.dart';
import '../../user/screens/userProfileScreen.dart'; // Ajusta el path si es necesario

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final EventService _eventService = EventService();
  List<EventModel> featured = [];
  List<EventModel> upcoming = [];
  bool loading = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    try {
      final events = await _eventService.fetchEvents();

      final destacados = [...events];
      destacados.sort((a, b) => b.asistentes.compareTo(a.asistentes));
      final topDestacados = destacados.take(3).toList();

      final proximos = [...events];
      proximos.sort((a, b) => DateTime.parse(a.fecha).compareTo(DateTime.parse(b.fecha)));

      setState(() {
        featured = topDestacados;
        upcoming = proximos;
        loading = false;
      });
    } catch (e) {
      print('Error al cargar eventos: \$e');
      setState(() => loading = false);
    }
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserProfileScreen()),
      );
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6C63FF);
    const backgroundColor = Color(0xFFF3F2F3);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SafeArea(
            child: Row(
              children: const [
                CircleAvatar(
                  backgroundColor: Color(0xFFE1E4ED),
                  child: Icon(Icons.notifications, color: primaryColor),
                ),
                SizedBox(width: 10),
                Text(
                  'UNAvoz',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: loadEvents,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (featured.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text('Eventos Destacados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    if (featured.isNotEmpty)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: featured.map((e) => FeaturedEventCard(event: e)).toList(),
                        ),
                      ),
                    const SizedBox(height: 24),
                    if (upcoming.isNotEmpty)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text('Próximos Eventos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    if (upcoming.isNotEmpty)
                      ...upcoming.map((e) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: UpcomingEventCard(event: e),
                          )),
                  ],
                ),
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
