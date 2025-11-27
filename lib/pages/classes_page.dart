import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/dashboard_card.dart';
import 'class_details_page.dart';

class ClassesPage extends StatelessWidget {
  const ClassesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample class data - in a real app, this would come from an API
    final List<Map<String, dynamic>> classes = [
      {'id': 1, 'name': 'XII RPL A', 'studentCount': 32},
      {'id': 2, 'name': 'XII RPL B', 'studentCount': 28},
      {'id': 3, 'name': 'XI TKJ A', 'studentCount': 30},
      {'id': 4, 'name': 'XI TKJ B', 'studentCount': 25},
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Classes',
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Select a class to view students and attendance reports',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 400, // Set a fixed height for the grid
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: classes.length,
                  itemBuilder: (context, index) {
                    final classData = classes[index];
                    return DashboardCard(
                      icon: Icons.groups,
                      title:
                          '${classData['name']}\n(${classData['studentCount']} students)',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ClassDetailsPage(classData: classData),
                          ),
                        );
                      },
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
