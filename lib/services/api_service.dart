import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../utils/constants.dart';

class ApiService {
  // Use the baseUrl from constants
  static const String baseUrl = AppConstants.baseUrl;

  // Student login
  static Future<Map<String, dynamic>> studentLogin(
    String nis,
    String password,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/student/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nis': nis, 'password': password}),
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      // Return a generic error response
      return {
        'statusCode': 500,
        'body': {'success': false, 'message': 'Network error: ${e.toString()}'},
      };
    }
  }

  // Teacher/Admin login
  static Future<Map<String, dynamic>> teacherLogin(
    String email,
    String password,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/teacher/login');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      // Return a generic error response
      return {
        'statusCode': 500,
        'body': {'success': false, 'message': 'Network error: ${e.toString()}'},
      };
    }
  }

  // Process attendance with face recognition
  static Future<Map<String, dynamic>> processAttendance(
    String token,
    XFile image,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/attendance/process');
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll({'Authorization': 'Bearer $token'});

      // Read image bytes - works for both mobile and web
      final bytes = await image.readAsBytes();

      final multipartFile = http.MultipartFile.fromBytes(
        'image',
        bytes,
        filename: image.name,
      );

      request.files.add(multipartFile);

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      // Try to parse the response
      dynamic parsedBody;
      try {
        parsedBody = jsonDecode(responseBody);
      } catch (e) {
        // If JSON parsing fails, return the raw response
        parsedBody = {
          'success': response.statusCode == 200,
          'message': 'Server response: $responseBody',
        };
      }

      return {'statusCode': response.statusCode, 'body': parsedBody};
    } catch (e) {
      // Return a generic error response
      return {
        'statusCode': 500,
        'body': {'success': false, 'message': 'Network error: ${e.toString()}'},
      };
    }
  }

  // Get student profile
  static Future<Map<String, dynamic>> getStudentProfile(String token) async {
    try {
      final url = Uri.parse('$baseUrl/student/profile');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      // Return a generic error response
      return {
        'statusCode': 500,
        'body': {'success': false, 'message': 'Network error: ${e.toString()}'},
      };
    }
  }

  // Get attendance history
  static Future<Map<String, dynamic>> getAttendanceHistory(String token) async {
    try {
      final url = Uri.parse('$baseUrl/student/attendance/history');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      // Return a generic error response
      return {
        'statusCode': 500,
        'body': {'success': false, 'message': 'Network error: ${e.toString()}'},
      };
    }
  }

  // Get all classes (teacher/admin)
  static Future<Map<String, dynamic>> getAllClasses(String token) async {
    try {
      final url = Uri.parse('$baseUrl/classes');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      // Return a generic error response
      return {
        'statusCode': 500,
        'body': {'success': false, 'message': 'Network error: ${e.toString()}'},
      };
    }
  }

  // Get students in class (teacher/admin)
  static Future<Map<String, dynamic>> getStudentsInClass(
    String token,
    int classId,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/classes/$classId/students');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      // Return a generic error response
      return {
        'statusCode': 500,
        'body': {'success': false, 'message': 'Network error: ${e.toString()}'},
      };
    }
  }

  // Get attendance report (teacher/admin)
  static Future<Map<String, dynamic>> getAttendanceReport(
    String token,
    int classId, {
    String? date,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/classes/$classId/attendance');
      final uri = Uri(
        scheme: url.scheme,
        host: url.host,
        port: url.port,
        path: url.path,
        queryParameters: date != null ? {'date': date} : null,
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      return {
        'statusCode': response.statusCode,
        'body': jsonDecode(response.body),
      };
    } catch (e) {
      // Return a generic error response
      return {
        'statusCode': 500,
        'body': {'success': false, 'message': 'Network error: ${e.toString()}'},
      };
    }
  }
}
