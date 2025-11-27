import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class StudentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> student;

  const StudentDetailsPage({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Student Details',
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Picture
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF4CAF50),
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),

              const SizedBox(height: 20),

              // Student Name
              Text(
                student['name'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 5),

              // Student NIS and Class
              Text(
                '${student['nis']} - ${student['class']}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Student Information Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Student Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

                      _buildInfoRow('Full Name', student['name']),
                      const Divider(),
                      _buildInfoRow('Student ID', student['id'].toString()),
                      const Divider(),
                      _buildInfoRow('NIS', student['nis']),
                      const Divider(),
                      _buildInfoRow('Class', student['class']),
                      const Divider(),
                      _buildInfoRow(
                        'Email',
                        '${student['name'].toLowerCase().replaceAll(' ', '.')}@school.edu',
                      ),
                      const Divider(),
                      _buildInfoRow('Phone', '+62 123 4567 890'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement edit student functionality
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // TODO: Implement view attendance history functionality
                      },
                      icon: const Icon(Icons.history),
                      label: const Text('History'),
                    ),
                  ),
                ],
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
}
