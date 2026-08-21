import 'package:flutter/material.dart';
import 'package:dental_client/dental_client.dart';
import '../../../services/serverpod_client.dart';

class PatientAppointmentsProvider extends ChangeNotifier {
  List<Appointment> _appointments = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Appointment> get appointments => _appointments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchAppointments() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _appointments = await client.appointment.getPatientAppointments();
    } catch (e) {
      debugPrint('fetchAppointments error: $e');
      _errorMessage = 'Failed to load appointments: ${e.toString().replaceAll('Exception: ', '')}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> cancelAppointment(int appointmentId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await client.appointment.cancelPatientAppointment(appointmentId);
      // Remove from list or change status
      final index = _appointments.indexWhere((a) => a.id == appointmentId);
      if (index != -1) {
        _appointments[index].status = AppointmentStatus.cancelled;
      }
      return true;
    } catch (e) {
      debugPrint('cancelAppointment error: $e');
      _errorMessage = 'Failed to cancel appointment: ${e.toString().replaceAll('Exception: ', '')}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
