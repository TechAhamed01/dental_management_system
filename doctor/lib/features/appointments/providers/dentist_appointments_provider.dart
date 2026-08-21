import 'package:flutter/material.dart';
import 'package:dental_client/dental_client.dart';
import '../../../services/serverpod_client.dart';

class DentistAppointmentsProvider extends ChangeNotifier {
  List<Appointment> _appointments = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Appointment> get appointments => _appointments;
  List<Appointment> get todaysAppointments {
    final now = DateTime.now();
    return _appointments.where((a) => a.date.year == now.year && a.date.month == now.month && a.date.day == now.day).toList();
  }
  List<Appointment> get upcomingAppointments {
    final now = DateTime.now();
    return _appointments.where((a) => !(a.date.year == now.year && a.date.month == now.month && a.date.day == now.day)).toList();
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchAppointments() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _appointments = await client.appointment.getDentistAppointments();
    } catch (e) {
      debugPrint('fetchAppointments error: $e');
      _errorMessage = 'Failed to load appointments: ${e.toString().replaceAll('Exception: ', '')}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
