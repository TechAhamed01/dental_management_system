import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../../providers/dentist_registration_provider.dart';

class VerificationStep extends StatelessWidget {
  const VerificationStep({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DentistRegistrationProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Verification Documents", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
          const SizedBox(height: 8),
          const Text("Please upload clear, legible copies of the following documents.", style: TextStyle(color: AppTheme.textSecondary)),
          const SizedBox(height: 24),
          
          if (provider.submitError != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: AppTheme.errorColor),
                  const SizedBox(width: 8),
                  Expanded(child: Text(provider.submitError!, style: const TextStyle(color: AppTheme.errorColor))),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          _DocumentUploader(
            title: "Medical Registration Certificate*",
            description: "State Dental Council Registration",
            fileName: provider.registrationFileName,
            onTap: () => provider.pickDocument('registration'),
          ),
          const SizedBox(height: 16),
          
          _DocumentUploader(
            title: "Degree Certificate*",
            description: "BDS / MDS Certificate",
            fileName: provider.degreeFileName,
            onTap: () => provider.pickDocument('degree'),
          ),
          const SizedBox(height: 16),
          
          _DocumentUploader(
            title: "Government ID*",
            description: "Aadhar Card, PAN Card, or Passport",
            fileName: provider.idFileName,
            onTap: () => provider.pickDocument('id'),
          ),
          const SizedBox(height: 16),
          
          _DocumentUploader(
            title: "Profile Photo (Optional)",
            description: "Recent passport-size photo",
            fileName: provider.profilePhotoName,
            onTap: () => provider.pickDocument('profile'),
          ),
          const SizedBox(height: 24),
          
          Row(
            children: [
              Checkbox(
                value: provider.isTermsAccepted,
                activeColor: AppTheme.primaryColor,
                onChanged: (val) => provider.setTermsAccepted(val ?? false),
              ),
              const Expanded(
                child: Text(
                  "I confirm that all uploaded documents are genuine and belong to the registered dentist.",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: provider.isTermsAccepted ? AppTheme.primaryColor : Colors.grey,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: provider.isSubmitting || !provider.isTermsAccepted
                  ? null
                  : () => provider.submitRegistration(),
              child: provider.isSubmitting
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text("Submit Registration", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentUploader extends StatelessWidget {
  final String title;
  final String description;
  final String? fileName;
  final VoidCallback onTap;

  const _DocumentUploader({
    required this.title,
    required this.description,
    this.fileName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasFile = fileName != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: hasFile ? AppTheme.successColor : Colors.grey.shade300, width: hasFile ? 2 : 1),
          borderRadius: BorderRadius.circular(12),
          color: hasFile ? AppTheme.successColor.withOpacity(0.05) : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              hasFile ? Icons.check_circle : Icons.upload_file,
              color: hasFile ? AppTheme.successColor : AppTheme.primaryColor,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    hasFile ? fileName! : description,
                    style: TextStyle(color: hasFile ? Colors.black87 : AppTheme.textSecondary, fontSize: 13),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (!hasFile)
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
