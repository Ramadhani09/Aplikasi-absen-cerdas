import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../utils/snackbar_utils.dart';
import 'student_home_page.dart';
import 'teacher_main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _nisController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isStudentLogin = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nisController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      bool success;
      if (_isStudentLogin) {
        success = await authProvider.studentLogin(
          _nisController.text.trim(),
          _passwordController.text,
        );
      } else {
        success = await authProvider.teacherLogin(
          _emailController.text.trim(),
          _passwordController.text,
        );
      }

      setState(() {
        _isLoading = false;
      });

      if (success) {
        // Navigate to appropriate home page
        if (_isStudentLogin) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const StudentHomePage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TeacherMainPage()),
          );
        }
      } else {
        SnackbarUtils.showErrorSnackbar(
          context,
          'Invalid credentials. Please try again.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 80),
                // App Logo/Title
                const Icon(Icons.school, size: 80, color: Color(0xFF4CAF50)),
                const SizedBox(height: 20),
                const Text(
                  'Smart Attendance',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Absen Cerdas',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 40),

                // Login Type Selector
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: true, label: Text('Student')),
                    ButtonSegment(value: false, label: Text('Teacher/Admin')),
                  ],
                  selected: {_isStudentLogin},
                  onSelectionChanged: (Set<bool> newSelection) {
                    setState(() {
                      _isStudentLogin = newSelection.first;
                    });
                  },
                ),
                const SizedBox(height: 30),

                // NIS Field (Student)
                if (_isStudentLogin)
                  TextFormField(
                    controller: _nisController,
                    decoration: const InputDecoration(
                      labelText: 'NIS',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your NIS';
                      }
                      return null;
                    },
                  ),

                // Email Field (Teacher/Admin)
                if (!_isStudentLogin)
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                const SizedBox(height: 20),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Error Message
                if (_errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Login', style: TextStyle(fontSize: 18)),
                ),

                const SizedBox(height: 30),

                // Footer
                const Text(
                  '© 2025 Smart Attendance System',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
