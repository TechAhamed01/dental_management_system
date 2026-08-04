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
      await client.auth.approveDentist(id, adminEmail: 'admin@dental.com');
      _pendingDentists.removeWhere((d) => d.id == id);
      if (_stats != null) {
        _stats = DashboardStats(
          totalPatients: _stats!.totalPatients,
          totalDoctors: _stats!.totalDoctors,
          pendingDoctors: _stats!.pendingDoctors - 1,
          approvedDoctors: _stats!.approvedDoctors + 1,
          rejectedDoctors: _stats!.rejectedDoctors,
          suspendedDoctors: _stats!.suspendedDoctors,
          terminatedDoctors: _stats!.terminatedDoctors,
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
      await client.auth.rejectDentist(id, adminEmail: 'admin@dental.com');
      _pendingDentists.removeWhere((d) => d.id == id);
      if (_stats != null) {
        _stats = DashboardStats(
          totalPatients: _stats!.totalPatients,
          totalDoctors: _stats!.totalDoctors,
          pendingDoctors: _stats!.pendingDoctors - 1,
          approvedDoctors: _stats!.approvedDoctors,
          rejectedDoctors: _stats!.rejectedDoctors + 1,
          suspendedDoctors: _stats!.suspendedDoctors,
          terminatedDoctors: _stats!.terminatedDoctors,
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

  Future<List<Dentist>> fetchSuspendedDentists() async {
    return await client.auth.getSuspendedDentists();
  }

  Future<List<Dentist>> fetchTerminatedDentists() async {
    return await client.auth.getTerminatedDentists();
  }

  Future<List<AuditLog>> fetchDentistAuditLogs(int dentistId) async {
    try {
      return await client.auth.getDentistAuditLogs(dentistId);
    } catch (e) {
      debugPrint('fetchDentistAuditLogs error: $e');
      return [];
    }
  }

  Future<Dentist?> searchDentistByCode(String code) async {
    _setLoading(true);
    _errorMessage = null;
    try {
      final dentist = await client.auth.searchDentistByCode(code);
      return dentist;
    } catch (e) {
      debugPrint('searchDentistByCode error: $e');
      _errorMessage = 'Search failed: ${e.toString().replaceAll('Exception: ', '')}';
      return null;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logPdfDownload(int dentistId) async {
    try {
      await client.auth.logPdfDownload(dentistId, adminEmail: 'admin@dental.com');
    } catch (e) {
      debugPrint('logPdfDownload error: $e');
    }
  }

  Future<bool> suspendDentist(int id, DateTime endsAt, String reason) async {
    _errorMessage = null;
    _setLoading(true);
    try {
      await client.auth.suspendDentist(id, endsAt, reason, adminEmail: 'admin@dental.com');
      await fetchDashboardData();
      return true;
    } catch (e) {
      debugPrint('suspendDentist error: $e');
      _errorMessage = 'Failed to suspend dentist: ${e.toString().replaceAll('Exception: ', '')}';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> terminateDentist(int id, String reason) async {
    _errorMessage = null;
    _setLoading(true);
    try {
      await client.auth.terminateDentist(id, reason, adminEmail: 'admin@dental.com');
      await fetchDashboardData();
      return true;
    } catch (e) {
      debugPrint('terminateDentist error: $e');
      _errorMessage = 'Failed to terminate dentist: ${e.toString().replaceAll('Exception: ', '')}';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
