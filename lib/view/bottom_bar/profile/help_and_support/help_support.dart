// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors

import 'package:authentication/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupport extends StatelessWidget {
  const HelpSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 20),
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const FAQItem(
            question: '1. How do I create an account?',
            answer:
                'To create an account, click on the "Sign Up" button, Fill the necessory fields and clik on sign up. Then login with ur email and password you have registered.',
          ),
          const FAQItem(
              question: '2. How do I sell a product on Sellgo?',
              answer:
                  'To sell a product on Sellgo, you need to create an account and go to the profile tab. Select Myproducts from the profile page. There is a button to add products to sell.'
              // list your product under the relevant category. Provide a detailed description, set your price, and upload high-quality images. Once listed, potential buyers can view and purchase your product.',
              ),
          const FAQItem(
            question: '3. How can I contact customer support?',
            answer:
                'You can contact customer support by emailing us at adnanvk916@gmail.com or by calling our helpline at +91 7025646162. Our support team is available from 9 AM to 6 PM, Monday to Friday.',
          ),
          const FAQItem(
            question: '4. What payment methods do you accept?',
            answer:
                'We accept credit/debit cards, UPI payments through RazorPay',
          ),
          const SizedBox(height: 20),
          const Text(
            'Contact Information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email: adnanvk12@gmail.com'),
            onTap: () {
              launchEmail('adnanvk12@gmail.com');
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Phone: +91 702 564 61 62'),
            onTap: () {
              launchPhone('+917025646162');
            },
          ),
        ],
      ),
    );
  }

  void launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  void launchPhone(String phoneNumber) async {
    final Uri phoneLaunchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    if (await canLaunch(phoneLaunchUri.toString())) {
      await launch(phoneLaunchUri.toString());
    } else {
      throw 'Could not launch $phoneLaunchUri';
    }
  }
}

class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      textColor: colors().blue,
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(answer),
        ),
      ],
    );
  }
}
