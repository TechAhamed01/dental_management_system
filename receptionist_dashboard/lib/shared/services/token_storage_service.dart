import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  static const _accessTokenKey = 'receptionist_access_token';
  static const _refreshTokenKey = 'receptionist_refresh_token';
  static const _receptionistIdKey = 'receptionist_id';
  static const _hospitalIdKey = 'hospital_id';

  final _storage = const FlutterSecureStorage();

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    int? receptionistId,
    int? hospitalId,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
    if (receptionistId != null) {
      await _storage.write(key: _receptionistIdKey, value: receptionistId.toString());
    }
    if (hospitalId != null) {
      await _storage.write(key: _hospitalIdKey, value: hospitalId.toString());
    }
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<int?> getReceptionistId() async {
    final idStr = await _storage.read(key: _receptionistIdKey);
    if (idStr != null) {
      return int.tryParse(idStr);
    }
    return null;
  }

  Future<int?> getHospitalId() async {
    final idStr = await _storage.read(key: _hospitalIdKey);
    if (idStr != null) {
      return int.tryParse(idStr);
    }
    return null;
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
    await _storage.delete(key: _receptionistIdKey);
    await _storage.delete(key: _hospitalIdKey);
  }
}
