import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme.dart';
import '../../providers/dentist_registration_provider.dart';
import '../../../../shared/widgets/custom_textfield.dart';

class BasicInfoStep extends StatelessWidget {
  const BasicInfoStep({super.key});

  Future<void> _selectDate(BuildContext context, DentistRegistrationProvider provider) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      provider.dobController.text = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DentistRegistrationProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: provider.basicInfoFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Basic Information", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryColor)),
            const SizedBox(height: 24),
            
            const Text("Full Name", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: provider.fullNameController,
              hintText: "Enter full name",
              validator: (value) {
                if (value == null || value.trim().isEmpty) return "Full Name is required";
                if (value.trim().length < 3) return "Minimum 3 characters";
                if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) return "Only letters are allowed";
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            const Text("Email", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: provider.emailController,
              hintText: "Enter email address",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) return "Email is required";
                if (!RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$').hasMatch(value)) return "Enter a valid email";
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            const Text("Phone Number", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: provider.phoneController,
              hintText: "Enter phone number",
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) return "Phone Number is required";
                if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) return "Enter a valid 10-digit phone number";
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            const Text("Date of Birth", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: provider.dobController,
              hintText: "Select Date of Birth (Optional)",
              readOnly: true,
              onTap: () => _selectDate(context, provider),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            const SizedBox(height: 20),
            
            const Text("Password", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: provider.passwordController,
              hintText: "Create a password",
              obscureText: true,
              suffixIcon: const Icon(Icons.visibility_off),
              validator: (value) {
                if (value == null || value.isEmpty) return "Password is required";
                if (value.length < 8) return "Password must be at least 8 characters";
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            const Text("Confirm Password", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            CustomTextField(
              controller: provider.confirmPasswordController,
              hintText: "Confirm your password",
              obscureText: true,
              suffixIcon: const Icon(Icons.visibility_off),
              validator: (value) {
                if (value == null || value.isEmpty) return "Confirm Password is required";
                if (value != provider.passwordController.text) return "Passwords do not match";
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
