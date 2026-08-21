import 'package:flutter/material.dart';
import 'package:dental_client/dental_client.dart' as dc;
import '../repositories/auth_repository.dart';
import '../services/token_storage_service.dart';
import '../services/serverpod_client.dart';

class LoginController extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final TokenStorageService _tokenStorage = TokenStorageService();

  bool _isLoading = false;
  String? _errorMessage;
  dc.Dentist? _currentDentist;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  dc.Dentist? get currentDentist => _currentDentist;

  Future<dc.Dentist?> login(String email, String password) async {
    debugPrint("[LoginController] Login button pressed for email: $email");
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final authResponse = await _authRepository.login(email, password);
      debugPrint("[LoginController] API response received: $authResponse");
      if (authResponse.dentist != null) {
        debugPrint("[LoginController] Dentist status received: ${authResponse.dentist!.status}");
        _currentDentist = authResponse.dentist!;
        await _tokenStorage.saveTokens(
          accessToken: authResponse.token!,
          refreshToken: authResponse.refreshToken!,
          dentistId: authResponse.dentist!.id,
        );
      } else {
        _errorMessage = "Invalid credentials or no response from server.";
      }
      return authResponse.dentist;
    } catch (e) {
      debugPrint("[LoginController] Exceptions during login: $e");
      _errorMessage = _parseError(e);
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      if (_currentDentist != null) {
        await client.auth.dentistLogout(_currentDentist!.id!);
      }
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      _currentDentist = null;
      await _tokenStorage.clearTokens();
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  String _parseError(dynamic e) {
    final str = e.toString();
    if (str.contains('ServerpodClientException:')) {
      return str.split('ServerpodClientException:').last.trim();
    } else if (str.contains('Exception:')) {
      return str.split('Exception:').last.trim();
    }
    return str;
  }
}
