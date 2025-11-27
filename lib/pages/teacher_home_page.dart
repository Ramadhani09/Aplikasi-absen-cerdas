import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/dashboard_card.dart';
import 'classes_page.dart';
import 'reports_page.dart';
import 'students_list_page.dart';
import 'settings_page.dart';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Teacher Info Card
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'User Profile',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('Name: ${user?.name ?? "N/A"}'),
                    Text('Email: ${user?.email ?? "N/A"}'),
                    Text('Role: ${user?.role ?? "N/A"}'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            // Dashboard Options
            SizedBox(
              height: 400, // Set a fixed height for the grid
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  DashboardCard(
                    icon: Icons.groups,
                    title: 'Classes',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ClassesPage(),
                        ),
                      );
                    },
                  ),
                  DashboardCard(
                    icon: Icons.assignment,
                    title: 'Reports',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReportsPage(),
                        ),
                      );
                    },
                  ),
                  DashboardCard(
                    icon: Icons.people,
                    title: 'Students',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudentsListPage(),
                        ),
                      );
                    },
                  ),
                  DashboardCard(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Add some bottom padding
          ],
        ),
      ),
    );
  }
}
