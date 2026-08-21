import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../../providers/dentist_registration_provider.dart';
import '../../../../shared/widgets/custom_textfield.dart';

class ProfessionalInfoStep extends StatelessWidget {
  const ProfessionalInfoStep({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DentistRegistrationProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: provider.professionalInfoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Professional Information", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
            const SizedBox(height: 24),
            
            const Text("Registration / License Number", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: provider.licenseController,
              hintText: "Enter your license number",
              validator: (value) {
                if (value == null || value.trim().isEmpty) return "License Number is required";
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            const Text("Specialization", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: provider.specializationController,
              hintText: "e.g., Orthodontist, General Dentist",
              validator: (value) {
                if (value == null || value.trim().isEmpty) return "Specialization is required";
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            const Text("Qualification", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: provider.qualificationController,
              hintText: "e.g., BDS, MDS (Optional)",
            ),
            const SizedBox(height: 20),
            
            const Text("Years of Experience", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: provider.experienceController,
              hintText: "Enter years of experience",
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) return "Experience is required";
                if (int.tryParse(value.trim()) == null) return "Enter a valid number";
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            const Text("Clinic Name", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: provider.clinicNameController,
              hintText: "Enter clinic name",
              validator: (value) {
                if (value == null || value.trim().isEmpty) return "Clinic Name is required";
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            const Text("Clinic Address", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: provider.clinicAddressController,
              hintText: "Enter clinic address",
              maxLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) return "Clinic Address is required";
                return null;
              },
            ),
            const SizedBox(height: 40),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: provider.nextStep,
                child: const Text("Next Step", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
