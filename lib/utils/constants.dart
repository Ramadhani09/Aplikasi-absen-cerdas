class AppConstants {
  static const String appName = 'Smart Attendance';
  static const String appVersion = '1.0.0';

  // API Constants
  static const String baseUrl = 'http://localhost:8000/api';

  // Shared Preferences Keys
  static const String tokenKey = 'token';

  // Role Constants
  static const String roleStudent = 'student';
  static const String roleTeacher = 'teacher';
  static const String roleAdmin = 'admin';

  // Status Constants
  static const String statusPresent = 'Hadir';
  static const String statusLate = 'Terlambat';
  static const String statusPermission = 'Izin';
  static const String statusSick = 'Sakit';
}
