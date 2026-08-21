import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../../../shared/services/serverpod_client.dart';

class DentistRegistrationProvider extends ChangeNotifier {
  // Step 1: Basic Info
  final GlobalKey<FormState> basicInfoFormKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  // Step 2: Professional Info
  final GlobalKey<FormState> professionalInfoFormKey = GlobalKey<FormState>();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController clinicAddressController = TextEditingController();

  // Step 3: Verification
  String? registrationFileUrl;
  String? degreeFileUrl;
  String? idFileUrl;
  String? profilePhotoUrl;
  
  String? registrationFileName;
  String? degreeFileName;
  String? idFileName;
  String? profilePhotoName;
  
  bool isTermsAccepted = false;

  bool _isSubmitting = false;
  String? _submitError;
  bool _isSuccess = false;

  bool get isSubmitting => _isSubmitting;
  String? get submitError => _submitError;
  bool get isSuccess => _isSuccess;

  // Page Navigation
  int _currentStep = 0;
  int get currentStep => _currentStep;
  final PageController pageController = PageController();

  void nextStep() {
    if (_currentStep == 0) {
      if (basicInfoFormKey.currentState?.validate() ?? false) {
        _currentStep++;
        pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        notifyListeners();
      }
    } else if (_currentStep == 1) {
      if (professionalInfoFormKey.currentState?.validate() ?? false) {
        _currentStep++;
        pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        notifyListeners();
      }
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      notifyListeners();
    }
  }

  void setTermsAccepted(bool value) {
    isTermsAccepted = value;
    notifyListeners();
  }

  Future<void> pickDocument(String type) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.bytes == null) return;
        
        final base64String = base64Encode(file.bytes!);
        final mimeType = _getMimeType(file.extension);
        final dataUrl = 'data:$mimeType;base64,$base64String';

        switch (type) {
          case 'registration':
            registrationFileUrl = dataUrl;
            registrationFileName = file.name;
            break;
          case 'degree':
            degreeFileUrl = dataUrl;
            degreeFileName = file.name;
            break;
          case 'id':
            idFileUrl = dataUrl;
            idFileName = file.name;
            break;
          case 'profile':
            profilePhotoUrl = dataUrl;
            profilePhotoName = file.name;
            break;
        }
        notifyListeners();
      }
    } catch (e) {
      debugPrint("File picking error: $e");
    }
  }

  String _getMimeType(String? extension) {
    switch (extension?.toLowerCase()) {
      case 'pdf': return 'application/pdf';
      case 'jpg':
      case 'jpeg': return 'image/jpeg';
      case 'png': return 'image/png';
      default: return 'application/octet-stream';
    }
  }

  Future<void> submitRegistration() async {
    if (!isTermsAccepted) {
      _submitError = "Please accept the Terms and Conditions";
      notifyListeners();
      return;
    }

    if (registrationFileUrl == null || degreeFileUrl == null || idFileUrl == null) {
      _submitError = "Please upload all required documents";
      notifyListeners();
      return;
    }

    _isSubmitting = true;
    _submitError = null;
    notifyListeners();

    try {
      await client.receptionist.receptionistRegisterDentist(
        fullNameController.text.trim(),
        emailController.text.trim(),
        phoneController.text.trim(),
        passwordController.text,
        dobController.text.trim().isNotEmpty ? dobController.text.trim() : null,
        licenseController.text.trim(),
        specializationController.text.trim(),
        qualificationController.text.trim().isNotEmpty ? qualificationController.text.trim() : null,
        int.tryParse(experienceController.text.trim()) ?? 0,
        clinicNameController.text.trim(),
        clinicAddressController.text.trim(),
        profilePhotoUrl,
        registrationFileUrl,
        degreeFileUrl,
        idFileUrl,
        isTermsAccepted,
      );

      _isSuccess = true;
    } catch (e) {
      _submitError = e.toString().replaceAll('Exception: ', '');
    } finally {
      _isSubmitting = false;
      notifyListeners();
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
    
    licenseController.dispose();
    specializationController.dispose();
    qualificationController.dispose();
    experienceController.dispose();
    clinicNameController.dispose();
    clinicAddressController.dispose();
    
    pageController.dispose();
    super.dispose();
  }
}
