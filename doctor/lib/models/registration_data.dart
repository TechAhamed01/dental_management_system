class RegistrationData {
  String fullName;
  String email;
  String phone;
  String password;

  // Professional
  String licenseNumber;
  String specialization;
  int experience;
  String clinicName;
  String clinicAddress;

  // Uploaded file names (not uploaded to server in this change)
  String? registrationFile;
  String? degreeFile;
  String? idFile;

  bool isTermsAccepted;

  RegistrationData({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    this.licenseNumber = '',
    this.specialization = '',
    this.experience = 0,
    this.clinicName = '',
    this.clinicAddress = '',
    this.registrationFile,
    this.degreeFile,
    this.idFile,
    this.isTermsAccepted = false,
  });
}
