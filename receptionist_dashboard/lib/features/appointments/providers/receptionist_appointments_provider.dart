import 'package:flutter/material.dart';
import 'package:dental_client/dental_client.dart';
import '../../../../shared/services/serverpod_client.dart';

class ReceptionistAppointmentsProvider extends ChangeNotifier {
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
      _appointments = await client.appointment.getHospitalAppointments();
    } catch (e) {
      debugPrint('fetchAppointments error: $e');
      _errorMessage = 'Failed to load appointments: ${e.toString().replaceAll('Exception: ', '')}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Dentist>> fetchAvailableDentists() async {
    try {
      return await client.appointment.getAvailableDentistsForAppointment();
    } catch (e) {
      debugPrint('fetchAvailableDentists error: $e');
      throw Exception('Failed to load available dentists.');
    }
  }

  Future<void> allocateDentist(int appointmentId, int dentistId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedAppointment = await client.appointment.allocateDentist(appointmentId, dentistId);
      
      // Update local list
      final index = _appointments.indexWhere((a) => a.id == appointmentId);
      if (index != -1) {
        // Instead of a full refresh, we can just fetch all again or replace the item.
        // Replacing the item is more efficient, but we might not have the full dentist object
        // So fetching all is safer to get the nested includes updated.
        await fetchAppointments();
      }
    } catch (e) {
      debugPrint('allocateDentist error: $e');
      _errorMessage = 'Allocation failed: ${e.toString().replaceAll('Exception: ', '')}';
      _isLoading = false;
      notifyListeners();
      throw e;
    }
  }
}
