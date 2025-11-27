import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class AttendanceReportPage extends StatelessWidget {
  final Map<String, dynamic> reportData;

  const AttendanceReportPage({Key? key, required this.reportData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Attendance Report',
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Report Header
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        reportData['className'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Date: ${reportData['date']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Total Students: ${reportData['totalStudents']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Attendance Summary
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Summary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildAttendanceStat(
                            'Hadir',
                            reportData['present'].toString(),
                            Colors.green,
                          ),
                          _buildAttendanceStat(
                            'Izin',
                            reportData['permission'].toString(),
                            Colors.blue,
                          ),
                          _buildAttendanceStat(
                            'Sakit',
                            reportData['sick'].toString(),
                            Colors.orange,
                          ),
                          _buildAttendanceStat(
                            'Alpha',
                            reportData['absent'].toString(),
                            Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Detailed Report
              const Text(
                'Detailed Report',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // Use a fixed height container instead of Expanded
              SizedBox(
                height: 400, // Set a fixed height for the list
                child: ListView.builder(
                  itemCount: reportData['details'].length,
                  itemBuilder: (context, index) {
                    final student = reportData['details'][index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFF4CAF50),
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        title: Text(student['name']),
                        subtitle: Text('${student['nis']}'),
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
