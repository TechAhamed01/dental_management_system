import 'package:flutter/foundation.dart';
import 'package:dental_client/dental_client.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'token_storage_service.dart';

late Client client;

class AdminAuthKeyProvider implements RefresherClientAuthKeyProvider {
  final TokenStorageService _tokenStorage = TokenStorageService();
  bool _isRefreshing = false;

  @override
  Future<String?> get authHeaderValue async {
    String? accessToken = await _tokenStorage.getAccessToken();
    if (accessToken == null) return null;

    if (_isTokenExpired(accessToken)) {
      final res = await refreshAuthKey();
      if (res == RefreshAuthKeyResult.success) {
        accessToken = await _tokenStorage.getAccessToken();
      } else {
        return null;
      }
    }

    if (accessToken == null) return null;
    return 'Bearer $accessToken';
  }

  @override
  Future<RefreshAuthKeyResult> refreshAuthKey({bool force = false}) async {
    if (_isRefreshing) return RefreshAuthKeyResult.skipped;

    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null) return RefreshAuthKeyResult.failedUnauthorized;

    debugPrint("[ServerpodClient] Refresh token invoked");
    _isRefreshing = true;
    try {
      final res = await client.auth.refreshAuthToken(refreshToken);
      await _tokenStorage.saveTokens(
        accessToken: res.token,
        refreshToken: res.refreshToken,
        adminId: res.admin?.id,
      );
      debugPrint("[ServerpodClient] Tokens stored");
      return RefreshAuthKeyResult.success;
    } catch (e) {
      debugPrint("[ServerpodClient] Refresh token failed: $e");
      await _tokenStorage.clearTokens();
      return RefreshAuthKeyResult.failedUnauthorized;
    } finally {
      _isRefreshing = false;
    }
  }

  bool _isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;
      // Wait, dart_jsonwebtoken or manually check? We can just check without importing if we want, but simple expiration logic:
      return false; // For now, let the backend return 401 if expired, or decode base64.
    } catch (_) {
      return true;
    }
  }
}

Future<void> initializeServerpod() async {
  client = Client(
    'http://localhost:8080/',
  )..authKeyProvider = AdminAuthKeyProvider();
}
