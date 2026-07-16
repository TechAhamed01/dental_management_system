import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dental_client/dental_client.dart' as dc;
import 'package:serverpod_client/serverpod_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'token_storage_service.dart';

late dc.Client client;

class PatientAuthKeyProvider implements RefresherClientAuthKeyProvider {
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
      final res = await client.auth.patientRefreshToken(refreshToken);
      await _tokenStorage.saveTokens(
        accessToken: res.token,
        refreshToken: res.refreshToken,
        patientId: res.patient?.id,
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
      final payload = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );
      if (payload is Map && payload.containsKey('exp')) {
        final exp = payload['exp'] as int;
        final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
        return DateTime.now().isAfter(
          expiryDate.subtract(const Duration(seconds: 30)),
        );
      }
    } catch (_) {
      return false;
    }
    return false;
  }
}

Future<void> initializeServerpod() async {
  client = dc.Client('http://localhost:8080/')
    ..authKeyProvider = PatientAuthKeyProvider()
    ..connectivityMonitor = FlutterConnectivityMonitor();
}
