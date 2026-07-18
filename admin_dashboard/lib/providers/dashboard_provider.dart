import 'package:flutter/material.dart';
import 'package:dental_client/dental_client.dart';
import '../services/serverpod_client.dart';

class DashboardProvider extends ChangeNotifier {
  List<Dentist> _pendingDentists = [];
  DashboardStats? _stats;
  bool _isLoading = false;
  String? _errorMessage;

  List<Dentist> get pendingDentists => _pendingDentists;
  DashboardStats? get stats => _stats;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDashboardData() async {
    _errorMessage = null;
    _setLoading(true);
    try {
      final dentists = await client.auth.getPendingDentists();
      final statsData = await client.auth.getDashboardStats();
      _pendingDentists = dentists;
      _stats = statsData;
      _errorMessage = null;
    } catch (e) {
      debugPrint('fetchDashboardData error: $e');
      _errorMessage = 'Failed to load dashboard data: ${e.toString().replaceAll('Exception: ', '')}';
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> approveDentist(int id) async {
    _errorMessage = null;
    notifyListeners();
    try {
      await client.auth.approveDentist(id);
      _pendingDentists.removeWhere((d) => d.id == id);
      if (_stats != null) {
        _stats = DashboardStats(
          totalPatients: _stats!.totalPatients,
          totalDoctors: _stats!.totalDoctors,
          pendingDoctors: _stats!.pendingDoctors - 1,
          approvedDoctors: _stats!.approvedDoctors + 1,
          rejectedDoctors: _stats!.rejectedDoctors,
        );
      }
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('approveDentist error: $e');
      _errorMessage = 'Failed to approve dentist: ${e.toString().replaceAll('Exception: ', '')}';
      notifyListeners();
      return false;
    }
  }

  Future<bool> rejectDentist(int id) async {
    _errorMessage = null;
    notifyListeners();
    try {
      await client.auth.rejectDentist(id);
      _pendingDentists.removeWhere((d) => d.id == id);
      if (_stats != null) {
        _stats = DashboardStats(
          totalPatients: _stats!.totalPatients,
          totalDoctors: _stats!.totalDoctors,
          pendingDoctors: _stats!.pendingDoctors - 1,
          approvedDoctors: _stats!.approvedDoctors,
          rejectedDoctors: _stats!.rejectedDoctors + 1,
        );
      }
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('rejectDentist error: $e');
      _errorMessage = 'Failed to reject dentist: ${e.toString().replaceAll('Exception: ', '')}';
      notifyListeners();
      return false;
    }
  }

  Future<List<Patient>> fetchAllPatients() async {
    return await client.auth.getAllPatients();
  }

  Future<List<Dentist>> fetchAllDentists() async {
    return await client.auth.getAllDentists();
  }

  Future<List<Dentist>> fetchApprovedDentists() async {
    return await client.auth.getApprovedDentists();
  }

  Future<List<Dentist>> fetchRejectedDentists() async {
    return await client.auth.getRejectedDentists();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
