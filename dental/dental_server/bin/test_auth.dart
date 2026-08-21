import 'package:dental_client/dental_client.dart';
import 'package:serverpod_client/serverpod_client.dart';

class SimpleAuthKeyProvider implements RefresherClientAuthKeyProvider {
  String? token;
  SimpleAuthKeyProvider(this.token);

  @override
  Future<String?> get authHeaderValue async {
    if (token == null) return null;
    return 'Bearer $token';
  }

  @override
  Future<RefreshAuthKeyResult> refreshAuthKey({bool force = false}) async {
    return RefreshAuthKeyResult.failedUnauthorized;
  }
}

void main() async {
  final client = Client('http://localhost:8080/');
  bool allPassed = true;

  void logResult(String name, bool passed) {
    print('${passed ? "✅ PASS" : "❌ FAIL"} - $name');
    if (!passed) allPassed = false;
  }

  print('==============================');
  print('PHASE 2.5 SECURITY TESTS');
  print('==============================');

  // 1. Unauthenticated Admin endpoint access -> DENIED
  try {
    await client.auth.getPendingDentists();
    logResult('Unauthenticated admin access', false);
  } catch (e) {
    logResult('Unauthenticated admin access', e.toString().contains('500') || e.toString().contains('Internal server error'));
  }

  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final hospitalEmail = 'hospital_$timestamp@test.local';
  final receptionistEmail = 'receptionist_$timestamp@test.local';
  
  String? adminToken;
  try {
    final response = await client.auth.adminLogin('admin@dental.ai', 'Admin@123');
    adminToken = response.token;
  } catch (e) {
    print('admin@dental.ai failed: $e');
    try {
      final response = await client.auth.adminLogin('admin@admin.com', 'Admin@123');
      adminToken = response.token;
    } catch(e) {
      print('Could not login as admin. Run bin/verify_phase2.dart or seed database to test further.');
    }
  }

  if (adminToken != null) {
    client.authKeyProvider = SimpleAuthKeyProvider(adminToken);
    
    // Create hospital
    var hospital = await client.hospital.createHospital(
      'Auth Test Hospital', 'Address', '12345', hospitalEmail
    );
    
    // Create Receptionist
    await client.receptionist.createReceptionist(
      hospital.id!, 'Test Recp', receptionistEmail, '12345', 'Pass@123'
    );
    
    // Login Receptionist
    client.authKeyProvider = null; // clear admin token
    final recpResponse = await client.receptionist.receptionistLogin(receptionistEmail, 'Pass@123');
    final recpToken = recpResponse.token;
    
    client.authKeyProvider = SimpleAuthKeyProvider(recpToken);
    
    // Receptionist trying to access getPendingDentists (Admin only) -> DENIED
    try {
      await client.auth.getPendingDentists();
      logResult('Receptionist accessing admin endpoint', false);
    } catch (e) {
      logResult('Receptionist accessing admin endpoint', e.toString().contains('500') || e.toString().contains('Internal server error'));
    }
    
    // Receptionist accessing own hospital -> ALLOWED
    try {
      final h = await client.hospital.getHospital(hospital.id!);
      logResult('Receptionist accessing own hospital', h?.id == hospital.id);
    } catch (e) {
      logResult('Receptionist accessing own hospital', false);
    }
    
    // Receptionist accessing OTHER hospital -> DENIED
    client.authKeyProvider = SimpleAuthKeyProvider(adminToken);
    final hospital2 = await client.hospital.createHospital('Other', 'Addr', '000', 'other$timestamp@test.local');
    
    client.authKeyProvider = SimpleAuthKeyProvider(recpToken);
    try {
      await client.hospital.getHospital(hospital2.id!);
      logResult('Receptionist accessing OTHER hospital', false);
    } catch (e) {
      logResult('Receptionist accessing OTHER hospital', e.toString().contains('500') || e.toString().contains('Internal server error'));
    }
  }
}
