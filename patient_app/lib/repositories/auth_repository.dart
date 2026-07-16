import 'package:flutter/foundation.dart';
import 'package:dental_client/dental_client.dart' as dc;
import '../services/serverpod_client.dart';

class AuthRepository {
  Future<dc.AuthResponse> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    debugPrint("[AuthRepository] Calling patientRegister");
    final response = await client.auth.patientRegister(
      fullName,
      email,
      phone,
      password,
    );
    debugPrint("[AuthRepository] Registration successful");
    if (response.patient != null && response.patient!.id != null) {
      debugPrint("[AuthRepository] Patient inserted successfully");
    }
    return response;
  }

  Future<dc.AuthResponse> login({
    required String email,
    required String password,
  }) async {
    debugPrint("[AuthRepository] Calling patientLogin");
    final response = await client.auth.patientLogin(
      email,
      password,
    );
    debugPrint("[AuthRepository] Login successful");
    return response;
  }

  Future<void> logout(int patientId) async {
    debugPrint("[AuthRepository] Calling patientLogout");
    await client.auth.patientLogout(patientId);
    debugPrint("[AuthRepository] Logout completed");
  }

  Future<dc.AuthResponse> refreshToken(String refreshToken) async {
    debugPrint("[AuthRepository] Refresh token invoked");
    return await client.auth.patientRefreshToken(refreshToken);
  }
}
