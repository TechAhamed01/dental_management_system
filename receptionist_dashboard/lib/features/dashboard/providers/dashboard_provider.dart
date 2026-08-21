import 'package:flutter/material.dart';
import 'package:dental_client/dental_client.dart';
import '../../../shared/services/serverpod_client.dart';

class DashboardProvider extends ChangeNotifier {
  Hospital? _hospital;
  bool _isLoading = false;
  String? _errorMessage;

  Hospital? get hospital => _hospital;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadHospitalContext(int hospitalId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final h = await client.hospital.getHospital(hospitalId);
      if (h != null) {
        _hospital = h;
      } else {
        _errorMessage = 'Hospital not found.';
      }
    } catch (e) {
      _errorMessage = 'Failed to load hospital context. Please try again.';
      debugPrint('Error loading hospital: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
