import 'package:flutter/material.dart';
import 'package:dental_client/dental_client.dart' as dc;
import '../repositories/auth_repository.dart';
import '../services/token_storage_service.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository _repository = AuthRepository();
  final TokenStorageService _tokenStorage = TokenStorageService();

  bool _isLoading = false;
  String? _errorMessage;
  dc.Patient? _currentPatient;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  dc.Patient? get currentPatient => _currentPatient;

  Future<bool> register({
    required String fullName,
    required String email,
    required String phone,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.register(
        fullName: fullName,
        email: email,
        phone: phone,
        password: password,
      );
      await _tokenStorage.saveTokens(
        accessToken: response.token,
        refreshToken: response.refreshToken,
        patientId: response.patient?.id,
      );
      debugPrint("[AuthController] Tokens stored");
      _currentPatient = response.patient;
      return true;
    } catch (e) {
      _errorMessage = _parseError(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.login(
        email: email,
        password: password,
      );
      await _tokenStorage.saveTokens(
        accessToken: response.token,
        refreshToken: response.refreshToken,
        patientId: response.patient?.id,
      );
      debugPrint("[AuthController] Tokens stored");
      _currentPatient = response.patient;
      return true;
    } catch (e) {
      _errorMessage = _parseError(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    try {
      int? patientId = _currentPatient?.id;
      patientId ??= await _tokenStorage.getPatientId();
      if (patientId != null) {
        await _repository.logout(patientId);
      }
    } catch (e) {
      debugPrint("[AuthController] Exception during logout: $e");
    } finally {
      await _tokenStorage.clearTokens();
      _currentPatient = null;
      _isLoading = false;
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
