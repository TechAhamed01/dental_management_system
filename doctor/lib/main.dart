import 'package:flutter/material.dart';
import 'screens/landing_page.dart';

void main() {
  runApp(const DentalCareApp());
}

class DentalCareApp extends StatelessWidget {
  const DentalCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DentalCare',
      home: const LandingPage(),
    );
  }
}