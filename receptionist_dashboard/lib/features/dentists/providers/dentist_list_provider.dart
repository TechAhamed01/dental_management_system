import 'package:flutter/material.dart';
import 'package:dental_client/dental_client.dart';
import '../../../shared/services/serverpod_client.dart';

class DentistListProvider extends ChangeNotifier {
  List<Dentist> _dentists = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Dentist> get dentists => _dentists;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDentists() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await client.receptionist.getDentistsForHospital();
      _dentists = data;
    } catch (e) {
      _errorMessage = 'Failed to load dentists: ${e.toString().replaceAll('Exception: ', '')}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
