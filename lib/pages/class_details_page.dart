import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class ClassDetailsPage extends StatelessWidget {
  final Map<String, dynamic> classData;

  const ClassDetailsPage({Key? key, required this.classData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample student data for this class - in a real app, this would come from an API
    final List<Map<String, dynamic>> students = [
      {'id': 1, 'name': 'Ahmad Rifai', 'nis': '1234567890', 'status': 'Hadir'},
      {'id': 2, 'name': 'Budi Santoso', 'nis': '1234567891', 'status': 'Hadir'},
      {'id': 3, 'name': 'Citra Dewi', 'nis': '1234567892', 'status': 'Izin'},
      {
        'id': 4,
        'name': 'Doni Prasetyo',
        'nis': '1234567893',
        'status': 'Sakit',
      },
      {'id': 5, 'name': 'Eka Putri', 'nis': '1234567894', 'status': 'Hadir'},
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: classData['name'],
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Class Information Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Class Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

                      _buildInfoRow('Class Name', classData['name']),
                      const Divider(),
                      _buildInfoRow(
                        'Student Count',
                        classData['studentCount'].toString(),
                      ),
                      const Divider(),
                      _buildInfoRow('Teacher', 'Dr. Supriyanto'),
                      const Divider(),
                      _buildInfoRow('Academic Year', '2025/2026'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Today's Attendance Summary
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Today\'s Attendance',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildAttendanceStat('Hadir', '3', Colors.green),
                          _buildAttendanceStat('Izin', '1', Colors.blue),
                          _buildAttendanceStat('Sakit', '1', Colors.orange),
                          _buildAttendanceStat('Alpha', '0', Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Students List
              const Text(
                'Students',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // Use a fixed height container instead of Expanded
              SizedBox(
                height: 400, // Set a fixed height for the list
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF4CAF50),
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(student['name']),
                        subtitle: Text(student['nis']),
                        trailing: _getStatusBadge(student['status']),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20), // Add some bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  Widget _buildAttendanceStat(String label, String count, Color color) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _getStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Hadir':
        color = Colors.green;
        break;
      case 'Izin':
        color = Colors.blue;
        break;
      case 'Sakit':
        color = Colors.orange;
        break;
      default:
        color = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
