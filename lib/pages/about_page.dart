import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'About',
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.school, size: 80, color: Color(0xFF4CAF50)),
              const SizedBox(height: 20),
              const Text(
                AppConstants.appName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Version ${AppConstants.appVersion}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Text(
                'Smart Attendance System is a modern solution for educational institutions to manage student attendance efficiently using face recognition technology.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Text(
                'Features:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.check_circle, color: Color(0xFF4CAF50)),
                title: Text('Face recognition-based attendance'),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle, color: Color(0xFF4CAF50)),
                title: Text('Real-time attendance tracking'),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle, color: Color(0xFF4CAF50)),
                title: Text('Detailed attendance reports'),
              ),
              const ListTile(
                leading: Icon(Icons.check_circle, color: Color(0xFF4CAF50)),
                title: Text('Multi-user support (students, teachers, admins)'),
              ),
              const Spacer(),
              const Text(
                '© 2025 Smart Attendance System',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20), // Add some bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
