import 'package:flutter/material.dart';
import './main.dart';

void main() {
  runApp(const MaterialApp(home: BhanuHeader()));
}

class BhanuHeader extends StatelessWidget {
  const BhanuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Notice Bar
            Container(
              color: Colors.deepPurple,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    '🔊 सूचनाहरू:',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    'राष्ट्रिय परिचय पत्र वितरण सम्बन्धमा • नागरिकता प्रमाण',
                    style: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text(
                      'समय: १२:४५ बजे',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
            ),

            // Main Header Row
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo Section
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/bhanu_logo.png'),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          Icon(Icons.file_copy, color: Colors.blue),
                          SizedBox(width: 5),
                          Text(
                            'नागरिक बडापत्र ✨',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(width: 20),

                  // Center Title Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'भानु नगरपालिक',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          'नगर कार्यपालिकाको कार्यालय',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'तनहुँ जिल्ला',
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),

                  // Time and Date Section
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: const [
                            Icon(Icons.access_time, color: Colors.white),
                            Text(
                              '१२:४५',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'आईतबार, दिउँसो',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: const [
                            Text(
                              '२९',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'जेठ २०८२',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'आईतबार',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 15),

                  // Contact Section
                  // Replace the entire Container with this:
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Card(
                      elevation: 6, // Increased for better shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            ContactInfoRow(
                              icon: Icons.phone,
                              text: '०६५-४२७७००',
                            ),
                            SizedBox(height: 8), // Added spacing
                            ContactInfoRow(
                              icon: Icons.language,
                              text: 'bhanu.gov.np',
                            ),
                            SizedBox(height: 8), // Added spacing
                            ContactInfoRow(
                              icon: Icons.email,
                              text: 'bhanu@gmail.com',
                            ),
                            SizedBox(height: 8), // Added spacing
                            ContactInfoRow(
                              icon: Icons.phone,
                              text: '०६५-४२७०९८',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContactInfoRow({required this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.red),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
