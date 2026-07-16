import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../services/serverpod_client.dart';

import '../models/registration_data.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../widgets/custom_button.dart';
import 'confirmation.dart';

class Verification extends StatefulWidget {
  final RegistrationData data;

  const Verification({super.key, required this.data});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  String? registrationFile;
  String? degreeFile;
  String? idFile;

  bool confirm = false;
  bool _loading = false;

  Future<void> _pickFile(void Function(String fileName) onPicked) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      onPicked(result.files.single.name);
    }
  }

  Future<void> _submitRegistration() async {
    if (registrationFile == null || degreeFile == null || idFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload all documents')),
      );
      return;
    }

    if (!confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please confirm declaration')),
      );
      return;
    }

    widget.data.registrationFile = registrationFile;
    widget.data.degreeFile = degreeFile;
    widget.data.idFile = idFile;
    widget.data.isTermsAccepted = confirm;

    setState(() {
      _loading = true;
    });

    try {
      final res = await client.auth.dentistRegister(
        widget.data.fullName,
        widget.data.email,
        widget.data.phone,
        widget.data.password,
        widget.data.licenseNumber,
        widget.data.specialization,
        widget.data.experience,
        widget.data.clinicName,
        widget.data.clinicAddress,
        null,
        widget.data.isTermsAccepted,
      );

      if (!mounted) return;

      if (res != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration submitted.')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Confirmation()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Registration failed.')));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Widget _buildUploadCard({
    required String title,
    required String? fileName,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final uploaded = fileName != null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: uploaded ? Colors.green : Colors.grey.shade400,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    uploaded ? Icons.check_circle : icon,
                    size: 36,
                    color: uploaded ? Colors.green : AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fileName ?? 'Tap to Upload',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: uploaded ? Colors.green : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'JPG, PNG or PDF (Max 5MB)',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Verification',
          style: TextStyle(
            color: AppColors.heading,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Step 3 of 3', style: AppTextStyles.subtitle),
              const SizedBox(height: 10),
              const LinearProgressIndicator(value: 1, minHeight: 8),
              const SizedBox(height: 30),
              const Text(
                'Verify Your Credentials',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('Upload required documents for verification.'),
              const SizedBox(height: 30),
              _buildUploadCard(
                title: 'Medical Registration Certificate',
                fileName: registrationFile,
                icon: Icons.description_outlined,
                onTap: () {
                  _pickFile((fileName) {
                    setState(() {
                      registrationFile = fileName;
                    });
                  });
                },
              ),
              _buildUploadCard(
                title: 'Degree Certificate',
                fileName: degreeFile,
                icon: Icons.school_outlined,
                onTap: () {
                  _pickFile((fileName) {
                    setState(() {
                      degreeFile = fileName;
                    });
                  });
                },
              ),
              _buildUploadCard(
                title: 'Government ID',
                fileName: idFile,
                icon: Icons.badge_outlined,
                onTap: () {
                  _pickFile((fileName) {
                    setState(() {
                      idFile = fileName;
                    });
                  });
                },
              ),
              CheckboxListTile(
                value: confirm,
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'I confirm that all information provided is accurate.',
                ),
                onChanged: (value) {
                  setState(() {
                    confirm = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: _loading ? 'Submitting...' : 'Submit',
                onPressed: _loading ? () {} : _submitRegistration,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
