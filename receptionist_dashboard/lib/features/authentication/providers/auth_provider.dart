import 'package:flutter/material.dart';
import 'package:dental_client/dental_client.dart';
import '../../../shared/services/serverpod_client.dart';
import '../../../shared/services/token_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  Receptionist? _currentReceptionist;
  bool _isLoading = false;
  String? _errorMessage;

  Receptionist? get currentReceptionist => _currentReceptionist;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentReceptionist != null;

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      final authResponse = await client.receptionist.receptionistLogin(email, password);
      if (authResponse.receptionist != null) {
        _currentReceptionist = authResponse.receptionist!;
        _errorMessage = null;
        
        final TokenStorageService tokenStorage = TokenStorageService();
        await tokenStorage.saveTokens(
          accessToken: authResponse.token,
          refreshToken: authResponse.refreshToken,
          receptionistId: authResponse.receptionist!.id,
          hospitalId: authResponse.receptionist!.hospitalId,
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

  Future<void> checkAuthState() async {
    final tokenStorage = TokenStorageService();
    final token = await tokenStorage.getAccessToken();
    if (token != null) {
      // In a real app we'd fetch the user profile here.
      // Since we don't have a getProfile endpoint, we just assume authenticated.
      // A failed request later will trigger token refresh or logout.
      _currentReceptionist = Receptionist(
        id: await tokenStorage.getReceptionistId(),
        hospitalId: await tokenStorage.getHospitalId() ?? 0,
        fullName: 'Receptionist',
        email: '',
        phone: '',
        passwordHash: '',
        isActive: true,
        createdAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      if (_currentReceptionist != null) {
        await client.receptionist.receptionistLogout(_currentReceptionist!.id!);
      }
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      _currentReceptionist = null;
      await TokenStorageService().clearTokens();
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String _parseError(dynamic e) {
    String error = e.toString();
    if (error.contains('Invalid email or password')) return 'Invalid email or password';
    if (error.contains('deactivated')) return 'Your account is deactivated';
    if (error.contains('Connection refused') || error.contains('Failed host lookup')) {
      return 'Cannot connect to server. Please try again later.';
    }
    return 'An unexpected error occurred. Please try again.';
  }
}
