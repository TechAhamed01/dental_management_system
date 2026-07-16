import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  static const _storage = FlutterSecureStorage();

  static const _accessTokenKey = 'jwt_access_token';
  static const _refreshTokenKey = 'jwt_refresh_token';
  static const _patientIdKey = 'patient_id';

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    int? patientId,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
    if (patientId != null) {
      await _storage.write(key: _patientIdKey, value: patientId.toString());
    }
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<int?> getPatientId() async {
    final idStr = await _storage.read(key: _patientIdKey);
    if (idStr != null) {
      return int.tryParse(idStr);
    }
    return null;
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _patientIdKey);
  }
}
