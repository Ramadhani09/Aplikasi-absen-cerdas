import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Privacy Policy',
        onBack: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Last updated: November 27, 2025',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Text(
                'At Smart Attendance System, we respect your privacy and are committed to protecting it through our compliance with this policy.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              const Text(
                'Information We Collect',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'We collect several types of information from and about users of our App, including information:\n\n'
                '• By which you may be personally identified ("personal information");\n'
                '• That is about you but individually does not identify you; and/or\n'
                '• About your internet connection, the equipment you use to access our App, and usage details.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              const Text(
                'How We Use Your Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'We use information that we collect about you or that you provide to us, including any personal information:\n\n'
                '• To present our App and its contents to you;\n'
                '• To provide you with information, products, or services that you request from us;\n'
                '• To fulfill any other purpose for which you provide it;\n'
                '• To carry out our obligations and enforce our rights;\n'
                '• To notify you about changes to our App or any products or services we offer or provide through it;\n'
                '• To allow you to participate in interactive features on our App;\n'
                '• To improve our App and develop new features;\n'
                '• To measure or understand the effectiveness of the advertising we serve to you and others;\n'
                '• To make suggestions and recommendations to you about goods or services that may be of interest to you.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              const Text(
                'Disclosure of Your Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'We may disclose aggregated information about our users, and information that does not identify any individual, without restriction.\n\n'
                'We may disclose personal information that we collect or you provide as described in this privacy policy:\n\n'
                '• To our affiliates;\n'
                '• To contractors, service providers, and other third parties we use to support our business;\n'
                '• To fulfill the purpose for which you provide it;\n'
                '• For any other purpose disclosed by us when you provide the information;\n'
                '• With your consent;\n'
                '• To comply with any court order, law, or legal process;\n'
                '• To protect the rights, property, or safety of our company, our customers, or others.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              const Text(
                'Data Security',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'We have implemented measures designed to secure your personal information from accidental loss and from unauthorized access, use, alteration, and disclosure.\n\n'
                'The safety and security of your information also depends on you. Where we have given you (or where you have chosen) a password for access to certain parts of our App, you are responsible for keeping this password confidential. We ask you not to share your password with anyone.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              const Text(
                'Changes to Our Privacy Policy',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'It is our policy to post any changes we make to our privacy policy on this page. If we make material changes to how we treat our users\' personal information, we will notify you through a notice on the App home page.\n\n'
                'The date the privacy policy was last revised is identified at the top of the page. You are responsible for ensuring we have an up-to-date active and deliverable email address for you, and for periodically visiting our App and this privacy policy to check for any changes.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              const Text(
                'Contact Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'To ask questions or comment about this privacy policy and our privacy practices, contact us at:\n\n'
                'Email: privacy@absencerda.com\n'
                'Phone: +62 123 4567 890',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
