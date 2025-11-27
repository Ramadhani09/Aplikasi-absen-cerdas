import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'student_details_page.dart';

class StudentsListPage extends StatelessWidget {
  const StudentsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample student data - in a real app, this would come from an API
    final List<Map<String, dynamic>> students = [
      {
        'id': 1,
        'name': 'Ahmad Rifai',
        'nis': '1234567890',
        'class': 'XII RPL A',
      },
      {
        'id': 2,
        'name': 'Budi Santoso',
        'nis': '1234567891',
        'class': 'XII RPL A',
      },
      {
        'id': 3,
        'name': 'Citra Dewi',
        'nis': '1234567892',
        'class': 'XII RPL A',
      },
      {
        'id': 4,
        'name': 'Doni Prasetyo',
        'nis': '1234567893',
        'class': 'XII RPL B',
      },
      {'id': 5, 'name': 'Eka Putri', 'nis': '1234567894', 'class': 'XII RPL B'},
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Students',
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Manage student accounts and view profiles',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search students...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Students List
              SizedBox(
                height: 500, // Set a fixed height for the list
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
                        subtitle: Text(
                          '${student['nis']} - ${student['class']}',
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StudentDetailsPage(student: student),
                            ),
                          );
                        },
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
}
