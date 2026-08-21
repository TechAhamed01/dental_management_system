import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../../providers/dentist_registration_provider.dart';
import 'basic_info_step.dart';
import 'professional_info_step.dart';
import 'verification_step.dart';
import 'registration_success_screen.dart';

class DentistRegistrationScreen extends StatelessWidget {
  const DentistRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DentistRegistrationProvider(),
      child: const _DentistRegistrationContent(),
    );
  }
}

class _DentistRegistrationContent extends StatefulWidget {
  const _DentistRegistrationContent();

  @override
  State<_DentistRegistrationContent> createState() => _DentistRegistrationContentState();
}

class _DentistRegistrationContentState extends State<_DentistRegistrationContent> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DentistRegistrationProvider>();

    if (provider.isSuccess) {
      return const RegistrationSuccessScreen();
    }

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Register New Dentist'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (provider.currentStep > 0) {
              provider.previousStep();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step ${provider.currentStep + 1} of 3",
                    style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: (provider.currentStep + 1) / 3,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: provider.pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swipe
                children: const [
                  BasicInfoStep(),
                  ProfessionalInfoStep(),
                  VerificationStep(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
