import 'package:flutter/material.dart';
import '../features/events/screens/events_screen.dart';
import '../features/home/screens/homeScreen.dart';
import '../features/user/screens/userProfileScreen.dart';
import '../features/home/widgets/customAppBar.dart';
import '../features/home/widgets/customBottomNav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    EventsScreen(),
    Center(child: Text('Notificaciones')), // Puedes reemplazar luego
    UserProfileScreen(),
  ];

  void _onTap(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}