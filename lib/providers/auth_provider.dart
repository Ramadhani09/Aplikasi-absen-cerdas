import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  User? _user;
  Student? _student;

  String? get token => _token;
  User? get user => _user;
  Student? get student => _student;
  bool get isAuthenticated => _token != null;

  // Load token from shared preferences on app start
  Future<void> loadToken() async {
    print('AuthProvider: Loading token...');
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token');
      print('AuthProvider: Token loaded: $_token');

      // If we have a token, validate it and load user data
      if (_token != null) {
        await _loadUserData();
      }
    } catch (e) {
      print('AuthProvider: Error loading token: $e');
      _token = null;
      _user = null;
      _student = null;
    }

    notifyListeners();
    print('AuthProvider: Notified listeners');
  }

  // Load user data based on token
  Future<void> _loadUserData() async {
    try {
      print('AuthProvider: Loading user data...');
      // We could validate the token here, but for now we'll just set the user type
      // based on what's already in the token or make an API call

      // For now, we'll assume the token is valid and just set the user type
      // In a real app, you'd make an API call to validate the token and get user data
    } catch (e) {
      print('AuthProvider: Error loading user data: $e');
      _token = null;
      _user = null;
      _student = null;
    }
  }

  // Student login
  Future<bool> studentLogin(String nis, String password) async {
    try {
      print('AuthProvider: Attempting student login...');
      final response = await ApiService.studentLogin(nis, password);

      if (response['statusCode'] == 200 && response['body']['success']) {
        _token = response['body']['data']['token'];
        _student = Student.fromJson(response['body']['data']['student']);
        _user = null; // Clear user data

        // Save token to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);

        notifyListeners();
        print('AuthProvider: Student login successful');
        return true;
      }
      print('AuthProvider: Student login failed');
      return false;
    } catch (e) {
      print('AuthProvider: Student login error: $e');
      return false;
    }
  }

  // Teacher/Admin login
  Future<bool> teacherLogin(String email, String password) async {
    try {
      print('AuthProvider: Attempting teacher login...');
      final response = await ApiService.teacherLogin(email, password);

      if (response['statusCode'] == 200 && response['body']['success']) {
        _token = response['body']['data']['token'];
        _user = User.fromJson(response['body']['data']['user']);
        _student = null; // Clear student data

        // Save token to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);

        notifyListeners();
        print('AuthProvider: Teacher login successful');
        return true;
      }
      print('AuthProvider: Teacher login failed');
      return false;
    } catch (e) {
      print('AuthProvider: Teacher login error: $e');
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    print('AuthProvider: Logging out...');
    _token = null;
    _user = null;
    _student = null;

    // Remove token from shared preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    notifyListeners();
    print('AuthProvider: Logout complete');
  }

  // Check if the authenticated user is a student
  bool get isStudent => _student != null;

  // Check if the authenticated user is a teacher/admin
  bool get isTeacher => _user != null;
}
