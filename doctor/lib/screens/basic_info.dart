import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'professional_info.dart';
import '../models/registration_data.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({super.key});

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController dobController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        dobController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Basic Information",
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

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                const Text(
                  "Step 1 of 3",
                  style: AppTextStyles.subtitle,
                ),

                const SizedBox(height: 10),

                const LinearProgressIndicator(
                  value: 0.33,
                  minHeight: 8,
                ),

                const SizedBox(height: 30),

                const Text("Full Name"),
                const SizedBox(height: 8),

                CustomTextField(
                  controller: fullNameController,
                  hintText: "Enter your full name",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Full Name is required";
                    }

                    if (value.trim().length < 3) {
                      return "Minimum 3 characters";
                    }

                    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                      return "Only letters are allowed";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                const Text("Email"),
                const SizedBox(height: 8),

                CustomTextField(
                  controller: emailController,
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }

                    if (!RegExp(
                      r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$',
                    ).hasMatch(value)) {
                      return "Enter a valid email";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                const Text("Phone Number"),
                const SizedBox(height: 8),

                CustomTextField(
                  controller: phoneController,
                  hintText: "Enter your phone number",
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone Number is required";
                    }

                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return "Enter a valid 10-digit phone number";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                const Text("Password"),
                const SizedBox(height: 8),

                CustomTextField(
                  controller: passwordController,
                  hintText: "Enter your password",
                  obscureText: true,
                  suffixIcon: const Icon(Icons.visibility_off),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }

                    if (value.length < 8) {
                      return "Password must be at least 8 characters";
                    }

                    return null;
                  },
                ),
                                const SizedBox(height: 20),

                const Text("Confirm Password"),
                const SizedBox(height: 8),

                CustomTextField(
                  controller: confirmPasswordController,
                  hintText: "Confirm your password",
                  obscureText: true,
                  suffixIcon: const Icon(Icons.visibility_off),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm Password is required";
                    }

                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                const Text("Date of Birth"),
                const SizedBox(height: 8),

                CustomTextField(
                  controller: dobController,
                  hintText: "Select Date of Birth",
                  readOnly: true,
                  onTap: _selectDate,
                  suffixIcon: const Icon(Icons.calendar_today),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Date of Birth is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 40),

                CustomButton(
                  text: "Next",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProfessionalInfo(
                              data: RegistrationData(
                                fullName: fullNameController.text.trim(),
                                email: emailController.text.trim(),
                                phone: phoneController.text.trim(),
                                password: passwordController.text,
                                dateOfBirth: dobController.text.trim(),
                              ),
                            ),
                          ),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}