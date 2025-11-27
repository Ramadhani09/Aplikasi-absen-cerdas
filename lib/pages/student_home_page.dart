import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import '../providers/auth_provider.dart';
import '../providers/attendance_provider.dart';
import '../utils/snackbar_utils.dart';
import 'login_page.dart';
import 'attendance_history_page.dart';
import 'student_profile_page.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  XFile? _capturedImage;
  Uint8List? _imageBytes; // Store image bytes for web compatibility
  bool _isProcessing = false;
  String? _processingMessage;
  int _retryCount = 0;
  static const int maxRetries = 3;

  Future<void> _takePicture() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        SnackbarUtils.showErrorSnackbar(context, 'No camera available');
        return;
      }

      final camera = cameras.first;
      final controller = CameraController(camera, ResolutionPreset.medium);
      await controller.initialize();

      if (!mounted) return;

      final XFile image = await controller.takePicture();
      await controller.dispose();

      // Load image bytes for web compatibility
      final bytes = await image.readAsBytes();

      setState(() {
        _capturedImage = image;
        _imageBytes = bytes;
      });
    } catch (e) {
      SnackbarUtils.showErrorSnackbar(context, 'Error taking picture: $e');
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Load image bytes for web compatibility
      final bytes = await image.readAsBytes();

      setState(() {
        _capturedImage = image;
        _imageBytes = bytes;
      });
    }
  }

  Future<void> _processAttendance() async {
    if (_capturedImage == null) {
      SnackbarUtils.showErrorSnackbar(
        context,
        'Please capture or select an image first',
      );
      return;
    }

    setState(() {
      _isProcessing = true;
      _processingMessage = 'Processing attendance...';
    });

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final attendanceProvider = Provider.of<AttendanceProvider>(
      context,
      listen: false,
    );

    final success = await attendanceProvider.processAttendance(
      authProvider.token!,
      _capturedImage!, // Pass the XFile directly
    );

    if (mounted) {
      setState(() {
        _isProcessing = false;
      });

      if (success) {
        SnackbarUtils.showSuccessSnackbar(
          context,
          'Attendance recorded successfully!',
        );
        setState(() {
          _capturedImage = null;
          _imageBytes = null;
          _retryCount = 0; // Reset retry count on success
        });
      } else {
        // Show more detailed error message
        final errorMessage =
            attendanceProvider.errorMessage ?? 'Failed to process attendance';

        // Implement retry mechanism
        if (_retryCount < maxRetries) {
          _retryCount++;
          SnackbarUtils.showInfoSnackbar(
            context,
            'Attempt $_retryCount failed. Retrying... ($errorMessage)',
          );

          // Retry after a short delay
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              _processAttendance();
            }
          });
        } else {
          // Max retries reached
          setState(() {
            _retryCount = 0; // Reset retry count
          });
          SnackbarUtils.showErrorSnackbar(
            context,
            'Failed after $_retryCount attempts: $errorMessage',
          );
        }
      }
    }
  }

  Future<void> _logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.logout();

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final student = authProvider.student;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StudentProfilePage(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Student Info Card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Student Profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Name: ${student?.name ?? "N/A"}'),
                      Text('NIS: ${student?.nis ?? "N/A"}'),
                      if (student?.classModel != null)
                        Text('Class: ${student?.classModel?.name ?? "N/A"}'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Attendance',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // Attendance Instructions
              const Text(
                'To record your attendance, please take a selfie or upload a photo of your face.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 30),

              // Image Preview
              if (_capturedImage != null && _imageBytes != null)
                Column(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.memory(_imageBytes!, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (_isProcessing)
                      Column(
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 10),
                          Text(_processingMessage ?? ''),
                        ],
                      ),
                    if (!_isProcessing)
                      ElevatedButton(
                        onPressed: _processAttendance,
                        child: const Text('Submit Attendance'),
                      ),
                  ],
                ),

              const SizedBox(height: 20),

              // Action Buttons
              if (_capturedImage == null && !_isProcessing)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _takePicture,
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Take Photo'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Choose Photo'),
                    ),
                  ],
                ),

              const SizedBox(height: 30),

              // Attendance History Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AttendanceHistoryPage(),
                    ),
                  );
                },
                child: const Text('View Attendance History'),
              ),
              const SizedBox(height: 20), // Add some bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
