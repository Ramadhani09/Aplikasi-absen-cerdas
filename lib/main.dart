import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'themes/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/attendance_provider.dart';
import 'pages/login_page.dart';
import 'pages/student_home_page.dart';
import 'pages/teacher_main_page.dart';
import 'widgets/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AttendanceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Attendance',
      theme: AppTheme.lightTheme,
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  Widget? _currentPage;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    print('AuthWrapper: Checking auth status...');
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    await authProvider.loadToken();

    print('AuthWrapper: isAuthenticated: ${authProvider.isAuthenticated}');
    print('AuthWrapper: isStudent: ${authProvider.isStudent}');
    print('AuthWrapper: isTeacher: ${authProvider.isTeacher}');

    Widget page;
    if (authProvider.isAuthenticated) {
      if (authProvider.isStudent) {
        print('AuthWrapper: Navigating to StudentHomePage');
        page = const StudentHomePage();
      } else if (authProvider.isTeacher) {
        print('AuthWrapper: Navigating to TeacherMainPage');
        page = const TeacherMainPage();
      } else {
        print('AuthWrapper: Navigating to LoginPage (unknown user type)');
        page = const LoginPage();
      }
    } else {
      print('AuthWrapper: Navigating to LoginPage (not authenticated)');
      page = const LoginPage();
    }

    if (mounted) {
      setState(() {
        _currentPage = page;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('AuthWrapper: Building widget, loading: $_loading');

    if (_loading) {
      print('AuthWrapper: Showing splash screen');
      return const SplashScreen();
    }

    return _currentPage ?? const LoginPage();
  }
}
