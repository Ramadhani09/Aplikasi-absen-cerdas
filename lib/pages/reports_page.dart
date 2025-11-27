import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'attendance_report_page.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Attendance Reports',
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Generate and view attendance reports',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Date Selection
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Date Range',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Start Date
                      Row(
                        children: [
                          const Expanded(child: Text('Start Date:')),
                          OutlinedButton(
                            onPressed: () {
                              // TODO: Show date picker
                            },
                            child: const Text('Select Date'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // End Date
                      Row(
                        children: [
                          const Expanded(child: Text('End Date:')),
                          OutlinedButton(
                            onPressed: () {
                              // TODO: Show date picker
                            },
                            child: const Text('Select Date'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Generate Report Button
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Generate report
                        },
                        child: const Text('Generate Report'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Recent Reports
              const Text(
                'Recent Reports',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              // Sample Report List
              SizedBox(
                height: 400, // Set a fixed height for the list
                child: ListView.builder(
                  itemCount: 5, // Sample data
                  itemBuilder: (context, index) {
                    // Sample report data
                    final reportData = {
                      'className': 'XII RPL A',
                      'date': DateTime.now()
                          .subtract(Duration(days: index))
                          .toString()
                          .split(' ')[0],
                      'totalStudents': 32,
                      'present': 28,
                      'permission': 2,
                      'sick': 1,
                      'absent': 1,
                      'details': [
                        {
                          'name': 'Ahmad Rifai',
                          'nis': '1234567890',
                          'status': 'Hadir',
                        },
                        {
                          'name': 'Budi Santoso',
                          'nis': '1234567891',
                          'status': 'Hadir',
                        },
                        {
                          'name': 'Citra Dewi',
                          'nis': '1234567892',
                          'status': 'Izin',
                        },
                      ],
                    };

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        title: Text(
                          'Class XII RPL A - ${DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0]}',
                        ),
                        subtitle: const Text('32 students, 28 present'),
                        trailing: const Icon(
                          Icons.picture_as_pdf,
                          color: Colors.red,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AttendanceReportPage(reportData: reportData),
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
