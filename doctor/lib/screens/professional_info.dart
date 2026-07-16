import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'verification.dart';
import '../models/registration_data.dart';

class ProfessionalInfo extends StatefulWidget {
  final RegistrationData data;
  const ProfessionalInfo({super.key, required this.data});

  @override
  State<ProfessionalInfo> createState() => _ProfessionalInfoState();
}

class _ProfessionalInfoState extends State<ProfessionalInfo> {
  final _formKey = GlobalKey<FormState>();

  final registrationController = TextEditingController();
  final hospitalController = TextEditingController();
  final addressController = TextEditingController();

  String? selectedSpecialization;
  String? selectedQualification;
  String? selectedExperience;

  @override
  void dispose() {
    registrationController.dispose();
    hospitalController.dispose();
    addressController.dispose();
    super.dispose();
  }

  InputDecoration fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xffD9DDE7)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 2,
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
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Professional Information",
          style: TextStyle(
            color: AppColors.heading,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                  "Step 2 of 3",
                  style: AppTextStyles.subtitle,
                ),

                const SizedBox(height: 10),

                const LinearProgressIndicator(
                  value: 0.66,
                  minHeight: 8,
                ),

                const SizedBox(height: 30),

                const Text(
                  "Medical Registration Number",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 8),

                CustomTextField(
                  controller: registrationController,
                  hintText: "Enter registration number",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Registration number is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                const Text(
                  "Specialization",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  initialValue: selectedSpecialization,
                  decoration: fieldDecoration("Select Specialization"),
                  items: const [

                    DropdownMenuItem(
                      value: "General Dentist",
                      child: Text("General Dentist"),
                    ),

                    DropdownMenuItem(
                      value: "Orthodontist",
                      child: Text("Orthodontist"),
                    ),

                    DropdownMenuItem(
                      value: "Endodontist",
                      child: Text("Endodontist"),
                    ),

                    DropdownMenuItem(
                      value: "Periodontist",
                      child: Text("Periodontist"),
                    ),

                    DropdownMenuItem(
                      value: "Oral Surgeon",
                      child: Text("Oral Surgeon"),
                    ),

                    DropdownMenuItem(
                      value: "Pediatric Dentist",
                      child: Text("Pediatric Dentist"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedSpecialization = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please select specialization";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                const Text(
                  "Qualification",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  initialValue: selectedQualification,
                  decoration: fieldDecoration("Select Qualification"),
                  items: const [

                    DropdownMenuItem(
                      value: "BDS",
                      child: Text("BDS"),
                    ),

                    DropdownMenuItem(
                      value: "MDS",
                      child: Text("MDS"),
                    ),

                    DropdownMenuItem(
                      value: "BDS, MDS",
                      child: Text("BDS, MDS"),
                    ),

                    DropdownMenuItem(
                      value: "PhD",
                      child: Text("PhD"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedQualification = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please select qualification";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                const Text(
                  "Years of Experience",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  initialValue: selectedExperience,
                  decoration: fieldDecoration("Select Experience"),
                  items: const [

                    DropdownMenuItem(
                      value: "0-2 Years",
                      child: Text("0-2 Years"),
                    ),

                    DropdownMenuItem(
                      value: "3-5 Years",
                      child: Text("3-5 Years"),
                    ),

                    DropdownMenuItem(
                      value: "6-10 Years",
                      child: Text("6-10 Years"),
                    ),

                    DropdownMenuItem(
                      value: "11-15 Years",
                      child: Text("11-15 Years"),
                    ),

                    DropdownMenuItem(
                      value: "15+ Years",
                      child: Text("15+ Years"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedExperience = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please select experience";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                const Text(
                  "Clinic / Hospital Name",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 8),

                CustomTextField(
                  controller: hospitalController,
                  hintText: "Enter clinic or hospital name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Clinic/Hospital name is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                const Text(
                  "Clinic Address",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 8),

                CustomTextField(
                  controller: addressController,
                  hintText: "Enter clinic address",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Clinic address is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 40),

                CustomButton(
                  text: "Next",
                  onPressed: () {

                    if (_formKey.currentState!.validate()) {

                      // update shared data and navigate
                      widget.data.licenseNumber = registrationController.text.trim();
                      widget.data.specialization = selectedSpecialization ?? '';

                      // map experience selection to an integer
                      switch (selectedExperience) {
                        case '0-2 Years':
                          widget.data.experience = 1;
                          break;
                        case '3-5 Years':
                          widget.data.experience = 4;
                          break;
                        case '6-10 Years':
                          widget.data.experience = 8;
                          break;
                        case '11-15 Years':
                          widget.data.experience = 13;
                          break;
                        case '15+ Years':
                          widget.data.experience = 20;
                          break;
                        default:
                          widget.data.experience = 0;
                      }

                      widget.data.clinicName = hospitalController.text.trim();
                      widget.data.clinicAddress = addressController.text.trim();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Verification(data: widget.data),
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