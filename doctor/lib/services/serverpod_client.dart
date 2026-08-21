import 'package:flutter/foundation.dart';
import 'package:dental_client/dental_client.dart' as dc;
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_client/serverpod_client.dart';
import 'token_storage_service.dart';

late dc.Client client;

class DentistAuthKeyProvider implements RefresherClientAuthKeyProvider {
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
        dentistId: res.dentist?.id,
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
      return false; // Let backend handle actual expiration
    } catch (_) {
      return true;
    }
  }
}

Future<void> initializeServerpod() async {
  client = dc.Client(
    'http://localhost:8080/',
  )
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authKeyProvider = DentistAuthKeyProvider();
}
