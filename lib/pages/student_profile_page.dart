import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_app_bar.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final student = authProvider.student;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Profile',
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Profile Picture Placeholder
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF4CAF50),
                child: Icon(Icons.person, size: 50, color: Colors.white),
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
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

                      _buildInfoRow('Full Name', student?.name ?? 'N/A'),
                      const Divider(),
                      _buildInfoRow('NIS', student?.nis ?? 'N/A'),
                      const Divider(),
                      _buildInfoRow(
                        'Class',
                        student?.classModel?.name ?? 'N/A',
                      ),
                      const Divider(),
                      _buildInfoRow(
                        'Student ID',
                        student?.id.toString() ?? 'N/A',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Action Buttons
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement edit profile functionality
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
              ),

              const SizedBox(height: 15),

              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement change password functionality
                },
                icon: const Icon(Icons.lock),
                label: const Text('Change Password'),
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
