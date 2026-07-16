import 'package:flutter/material.dart';
import 'package:dental_client/dental_client.dart' as dc;
import '../repositories/auth_repository.dart';

class LoginController extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

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
      final dentist = await _authRepository.login(email, password);
      debugPrint("[LoginController] API response received: $dentist");
      if (dentist != null) {
        debugPrint("[LoginController] Dentist status received: ${dentist.status}");
        _currentDentist = dentist;
      } else {
        _errorMessage = "Invalid credentials or no response from server.";
      }
      return dentist;
    } catch (e) {
      debugPrint("[LoginController] Exceptions during login: $e");
      _errorMessage = _parseError(e);
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _currentDentist = null;
    notifyListeners();
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
