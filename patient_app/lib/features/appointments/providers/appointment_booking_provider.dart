import 'package:flutter/material.dart';
import 'package:dental_client/dental_client.dart';
import '../../../services/serverpod_client.dart';

class AppointmentBookingProvider extends ChangeNotifier {
  List<Hospital> _activeHospitals = [];
  bool _isLoading = false;
  String? _errorMessage;

  Hospital? _selectedHospital;
  DateTime? _selectedDate;
  String? _selectedStartTime;
  String? _selectedEndTime;
  String? _reason;

  List<Hospital> get activeHospitals => _activeHospitals;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Hospital? get selectedHospital => _selectedHospital;
  DateTime? get selectedDate => _selectedDate;
  String? get selectedStartTime => _selectedStartTime;
  String? get selectedEndTime => _selectedEndTime;
  String? get reason => _reason;

  Future<void> fetchActiveHospitals() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _activeHospitals = await client.hospital.listActiveHospitals();
    } catch (e) {
      debugPrint('fetchActiveHospitals error: $e');
      _errorMessage = 'Failed to load hospitals: ${e.toString().replaceAll('Exception: ', '')}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectHospital(Hospital hospital) {
    _selectedHospital = hospital;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void selectTimeSlot(String startTime, String endTime) {
    _selectedStartTime = startTime;
    _selectedEndTime = endTime;
    notifyListeners();
  }

  void setReason(String reason) {
    _reason = reason;
    notifyListeners();
  }

  void resetBooking() {
    _selectedHospital = null;
    _selectedDate = null;
    _selectedStartTime = null;
    _selectedEndTime = null;
    _reason = null;
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> submitAppointmentRequest() async {
    if (_selectedHospital == null || _selectedDate == null || _selectedStartTime == null || _selectedEndTime == null || _reason == null) {
      _errorMessage = 'Please complete all fields before submitting.';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await client.appointment.createAppointment(
        _selectedHospital!.id!,
        _selectedDate!,
        _selectedStartTime!,
        _selectedEndTime!,
        _reason!,
      );
      return true;
    } catch (e) {
      debugPrint('submitAppointmentRequest error: $e');
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
