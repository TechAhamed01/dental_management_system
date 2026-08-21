import 'package:flutter/material.dart';
import 'package:dental_client/dental_client.dart';
import '../services/serverpod_client.dart';
import '../services/token_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  Admin? _currentAdmin;
  bool _isLoading = false;
  String? _errorMessage;

  Admin? get currentAdmin => _currentAdmin;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentAdmin != null;

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      final authResponse = await client.auth.adminLogin(email, password);
      if (authResponse.admin != null) {
        _currentAdmin = authResponse.admin!;
        _errorMessage = null;
        
        final TokenStorageService tokenStorage = TokenStorageService();
        await tokenStorage.saveTokens(
          accessToken: authResponse.token!,
          refreshToken: authResponse.refreshToken!,
          adminId: authResponse.admin!.id,
        );
        
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Invalid credentials';
        return false;
      }
    } catch (e) {
      _errorMessage = _parseError(e);
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      if (_currentAdmin != null) {
        await client.auth.adminLogout(_currentAdmin!.id!);
      }
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      _currentAdmin = null;
      await TokenStorageService().clearTokens();
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _parseError(dynamic e) {
    // Basic error parsing
    final str = e.toString();
    if (str.contains('Exception:')) {
      return str.split('Exception:').last.trim();
    }
    return 'An error occurred during login';
  }
}
