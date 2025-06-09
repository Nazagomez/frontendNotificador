import 'package:flutter/material.dart';
import '../../events/models/eventModels.dart';
import '../../events/services/eventServices.dart';
import '../../events/widgets/featuredEventCard.dart';
import '../../events/widgets/upcomingEventCard.dart';

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

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  Future<void> loadEvents() async {
    try {
      final events = await _eventService.fetchEvents();

      final destacados = [...events]..sort((a, b) => b.asistentes.compareTo(a.asistentes));
      final proximos = [...events]..sort((a, b) => DateTime.parse(a.fecha).compareTo(DateTime.parse(b.fecha)));

      setState(() {
        featured = destacados.take(3).toList();
        upcoming = proximos;
        loading = false;
      });
    } catch (e) {
      print('Error al cargar eventos: $e');
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
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
                      child: Row(children: featured.map((e) => FeaturedEventCard(event: e)).toList()),
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
          );
  }
}