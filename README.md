# Smart Attendance System (Absen Cerdas)

A modern Flutter application for smart attendance management with face recognition capabilities.

## Features

- **Student Portal**
  - Face recognition-based attendance
  - Attendance history tracking
  - Profile management

- **Teacher/Admin Portal**
  - Class management
  - Student attendance reports
  - Real-time attendance monitoring

## Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Laravel API (separate repository)
- **Database**: MySQL
- **Authentication**: Laravel Sanctum
- **Face Recognition**: Google ML Kit

## Dependencies

- `http` - For API communication
- `provider` - State management
- `shared_preferences` - Local data storage
- `camera` - Camera functionality for face capture
- `image_picker` - Gallery image selection
- `path_provider` - File path management
- `path` - File path utilities

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd absen_cerdas
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## Folder Structure

```
lib/
├── main.dart
├── models/
│   ├── user.dart
│   └── attendance.dart
├── providers/
│   ├── auth_provider.dart
│   └── attendance_provider.dart
├── services/
│   └── api_service.dart
├── pages/
│   ├── login_page.dart
│   ├── student_home_page.dart
│   └── teacher_home_page.dart
├── themes/
│   └── app_theme.dart
├── widgets/
│   ├── splash_screen.dart
│   ├── custom_app_bar.dart
│   └── dashboard_card.dart
└── utils/
    ├── constants.dart
    └── snackbar_utils.dart
```

## Color Scheme

The application uses a green-themed color palette:
- Primary Green: #4CAF50
- Dark Green: #388E3C
- Light Green: #C8E6C9
- Accent Green: #8BC34A

## API Integration

The app connects to a Laravel backend API. Make sure the backend is running at `http://localhost:8000` or update the `baseUrl` in `lib/utils/constants.dart`.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- Laravel team for the robust backend
- Google ML Kit for face recognition capabilities