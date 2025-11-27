import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/attendance.dart';
import '../services/api_service.dart';

class AttendanceProvider with ChangeNotifier {
  List<Attendance> _attendanceHistory = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Attendance> get attendanceHistory => _attendanceHistory;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Process attendance with face recognition
  Future<bool> processAttendance(String token, XFile image) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await ApiService.processAttendance(token, image);

      // Check if the response has the expected structure
      if (response['statusCode'] == 200) {
        final body = response['body'];

        // Handle different response formats
        if (body is Map<String, dynamic>) {
          if (body['success'] == true) {
            _isLoading = false;
            notifyListeners();
            return true;
          } else {
            // Show more detailed error message from backend
            final errorMessage =
                body['message'] ??
                'Failed to process attendance (HTTP ${response['statusCode']})';
            _errorMessage = errorMessage;
            _isLoading = false;
            notifyListeners();
            return false;
          }
        } else {
          // Unexpected response format
          _errorMessage = 'Unexpected response format from server';
          _isLoading = false;
          notifyListeners();
          return false;
        }
      } else {
        // Handle HTTP error status codes
        final body = response['body'];
        String errorMessage;

        if (body is Map<String, dynamic> && body['message'] != null) {
          errorMessage = body['message'];
        } else {
          errorMessage =
              'Failed to process attendance (HTTP ${response['statusCode']})';
        }

        _errorMessage = errorMessage;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Get attendance history
  Future<void> getAttendanceHistory(String token) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await ApiService.getAttendanceHistory(token);

      if (response['statusCode'] == 200 && response['body']['success']) {
        final List<dynamic> data = response['body']['data'];
        _attendanceHistory = data
            .map((item) => Attendance.fromJson(item))
            .toList();
        _isLoading = false;
        notifyListeners();
      } else {
        _errorMessage =
            response['body']['message'] ?? 'Failed to load attendance history';
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      _isLoading = false;
      notifyListeners();
    }
  }
}
