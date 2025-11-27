import 'package:flutter/material.dart';
import '../pages/teacher_home_page.dart';
import '../pages/classes_page.dart';
import '../pages/reports_page.dart';

class BottomNavigation extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabTapped;

  const BottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTabTapped,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // Wrap each page with SingleChildScrollView to prevent overflow
    _pages = [
      const SingleChildScrollView(child: TeacherHomePage()),
      const SingleChildScrollView(child: ClassesPage()),
      const SingleChildScrollView(child: ReportsPage()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Classes'),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Reports',
          ),
        ],
        currentIndex: widget.currentIndex,
        selectedItemColor: const Color(0xFF4CAF50),
        onTap: widget.onTabTapped,
      ),
    );
  }
}
