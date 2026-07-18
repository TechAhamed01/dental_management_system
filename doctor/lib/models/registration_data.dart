class RegistrationData {
  String fullName;
  String email;
  String phone;
  String password;
  String? dateOfBirth;

  // Professional
  String licenseNumber;
  String specialization;
  String? qualification;
  int experience;
  String clinicName;
  String clinicAddress;

  // Uploaded file data / names
  String? registrationFile;
  String? degreeFile;
  String? idFile;

  bool isTermsAccepted;

  RegistrationData({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    this.dateOfBirth,
    this.licenseNumber = '',
    this.specialization = '',
    this.qualification = '',
    this.experience = 0,
    this.clinicName = '',
    this.clinicAddress = '',
    this.registrationFile,
    this.degreeFile,
    this.idFile,
    this.isTermsAccepted = false,
  });
}
