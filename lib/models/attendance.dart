class Attendance {
  final int id;
  final int studentId;
  final String date;
  final String time;
  final String status;
  final String deviceInfo;

  Attendance({
    required this.id,
    required this.studentId,
    required this.date,
    required this.time,
    required this.status,
    required this.deviceInfo,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      studentId: json['student_id'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
      deviceInfo: json['device_info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'date': date,
      'time': time,
      'status': status,
      'device_info': deviceInfo,
    };
  }
}
