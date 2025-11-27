import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Help & Support',
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'How can we help you?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Find answers to common questions or contact our support team',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // FAQ Section
              const Text(
                'Frequently Asked Questions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              ExpansionTile(
                title: const Text('How do I record my attendance?'),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'To record your attendance, go to the Student Dashboard and tap either "Take Photo" to capture a new selfie or "Choose Photo" to select an existing photo from your gallery. Once you have selected or taken a photo, tap "Submit Attendance" to process it.',
                    ),
                  ),
                ],
              ),

              ExpansionTile(
                title: const Text(
                  'What should I do if my attendance is not recorded?',
                ),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'If your attendance is not recorded, make sure that:\n\n1. Your face is clearly visible in the photo\n2. There is adequate lighting\n3. You are not wearing accessories that obscure your face\n4. You have a stable internet connection\n\nIf the problem persists, contact your teacher or administrator for assistance.',
                    ),
                  ),
                ],
              ),

              ExpansionTile(
                title: const Text('How do I view my attendance history?'),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'To view your attendance history, go to the Student Dashboard and tap "View Attendance History". You will see a list of all your recorded attendance entries with dates and statuses.',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Contact Support
              const Text(
                'Contact Support',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Need further assistance? Our support team is here to help.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      const ListTile(
                        leading: Icon(Icons.email, color: Color(0xFF4CAF50)),
                        title: Text('support@absencerda.com'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.phone, color: Color(0xFF4CAF50)),
                        title: Text('+62 123 4567 890'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Implement contact support functionality
                        },
                        child: const Text('Send Message'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add some bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
