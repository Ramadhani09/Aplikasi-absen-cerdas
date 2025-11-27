import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/attendance_provider.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';

class AttendanceHistoryPage extends StatefulWidget {
  const AttendanceHistoryPage({Key? key}) : super(key: key);

  @override
  State<AttendanceHistoryPage> createState() => _AttendanceHistoryPageState();
}

class _AttendanceHistoryPageState extends State<AttendanceHistoryPage> {
  @override
  void initState() {
    super.initState();
    _loadAttendanceHistory();
  }

  Future<void> _loadAttendanceHistory() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final attendanceProvider = Provider.of<AttendanceProvider>(
      context,
      listen: false,
    );

    await attendanceProvider.getAttendanceHistory(authProvider.token!);
  }

  String _getStatusColor(String status) {
    switch (status) {
      case AppConstants.statusPresent:
        return 'Hadir';
      case AppConstants.statusLate:
        return 'Terlambat';
      case AppConstants.statusPermission:
        return 'Izin';
      case AppConstants.statusSick:
        return 'Sakit';
      default:
        return status;
    }
  }

  Color _getStatusBackgroundColor(String status) {
    switch (status) {
      case AppConstants.statusPresent:
        return Colors.green.withValues(alpha: 0.2);
      case AppConstants.statusLate:
        return Colors.orange.withValues(alpha: 0.2);
      case AppConstants.statusPermission:
      case AppConstants.statusSick:
        return Colors.blue.withValues(alpha: 0.2);
      default:
        return Colors.grey.withValues(alpha: 0.2);
    }
  }

  Color _getStatusTextColor(String status) {
    switch (status) {
      case AppConstants.statusPresent:
        return Colors.green;
      case AppConstants.statusLate:
        return Colors.orange;
      case AppConstants.statusPermission:
      case AppConstants.statusSick:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Attendance History',
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<AttendanceProvider>(
            builder: (context, attendanceProvider, child) {
              if (attendanceProvider.isLoading &&
                  attendanceProvider.attendanceHistory.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              if (attendanceProvider.errorMessage != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        attendanceProvider.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _loadAttendanceHistory,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              final attendanceList = attendanceProvider.attendanceHistory;

              if (attendanceList.isEmpty) {
                return const Center(child: Text('No attendance records found'));
              }

              return ListView.builder(
                shrinkWrap:
                    true, // Allow ListView to work inside SingleChildScrollView
                physics:
                    const NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
                itemCount: attendanceList.length,
                itemBuilder: (context, index) {
                  final attendance = attendanceList[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        '${attendance.date} at ${attendance.time}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(attendance.deviceInfo),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusBackgroundColor(attendance.status),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getStatusColor(attendance.status),
                          style: TextStyle(
                            color: _getStatusTextColor(attendance.status),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
