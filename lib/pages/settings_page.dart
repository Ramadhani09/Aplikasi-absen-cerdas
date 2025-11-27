import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'about_page.dart';
import 'help_support_page.dart';
import 'privacy_policy_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        onBack: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Manage your app preferences',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Settings Categories
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.notifications,
                        color: Color(0xFF4CAF50),
                      ),
                      title: const Text('Notifications'),
                      trailing: const Switch(value: true, onChanged: null),
                      onTap: () {
                        // TODO: Handle notifications toggle
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.brightness_6,
                        color: Color(0xFF4CAF50),
                      ),
                      title: const Text('Dark Mode'),
                      trailing: const Switch(value: false, onChanged: null),
                      onTap: () {
                        // TODO: Handle dark mode toggle
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.language,
                        color: Color(0xFF4CAF50),
                      ),
                      title: const Text('Language'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // TODO: Handle language selection
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info, color: Color(0xFF4CAF50)),
                      title: const Text('About'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutPage(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.privacy_tip,
                        color: Color(0xFF4CAF50),
                      ),
                      title: const Text('Privacy Policy'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyPage(),
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.help, color: Color(0xFF4CAF50)),
                      title: const Text('Help & Support'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpSupportPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Logout Button
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement logout functionality
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
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
