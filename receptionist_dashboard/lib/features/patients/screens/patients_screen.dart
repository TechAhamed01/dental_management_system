import 'package:flutter/material.dart';
import '../../../shared/widgets/coming_soon_placeholder.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Directory'),
      ),
      body: const ComingSoonPlaceholder(
        title: 'Patient Directory',
        description: 'View patient records, appointment history, and demographic information for patients assigned to this hospital.',
        icon: Icons.people_outline,
      ),
    );
  }
}
