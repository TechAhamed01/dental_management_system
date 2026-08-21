import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils/auth_utils.dart';

class AppointmentEndpoint extends Endpoint {
  
  /// Creates a new appointment request from a Patient.
  Future<Appointment> createAppointment(
    Session session,
    int hospitalId,
    DateTime date,
    String startTime,
    String endTime,
    String reason,
  ) async {
    final authUser = AuthUtils.requireRole(session, ['patient']);
    
    // Validations
    final now = DateTime.now();
    // Compare dates ignoring time
    final dateOnly = DateTime(date.year, date.month, date.day);
    final todayOnly = DateTime(now.year, now.month, now.day);
    if (dateOnly.isBefore(todayOnly)) {
      throw Exception('Cannot book an appointment in the past.');
    }
    
    if (startTime.compareTo(endTime) >= 0) {
      throw Exception('Invalid time slot. End time must be after start time.');
    }
    
    // Check if hospital is active
    final hospital = await Hospital.db.findById(session, hospitalId);
    if (hospital == null) {
      throw Exception('Hospital not found.');
    }
    if (!hospital.isActive) {
      throw Exception('Selected hospital is currently inactive.');
    }
    
    // Check for duplicates (same patient, hospital, date, time, and pending)
    final existingList = await Appointment.db.find(
      session,
      where: (t) => 
        t.patientId.equals(authUser.userId) & 
        t.hospitalId.equals(hospitalId) &
        t.date.equals(date) &
        t.startTime.equals(startTime) &
        t.endTime.equals(endTime) &
        t.status.equals(AppointmentStatus.pending),
    );
    
    if (existingList.isNotEmpty) {
      throw Exception('You already have a pending appointment request for this slot.');
    }
    
    final appointment = Appointment(
      patientId: authUser.userId,
      hospitalId: hospitalId,
      date: date,
      startTime: startTime,
      endTime: endTime,
      reason: reason,
      status: AppointmentStatus.pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    return await Appointment.db.insertRow(session, appointment);
  }

  /// Gets appointments for the authenticated patient
  Future<List<Appointment>> getPatientAppointments(Session session) async {
    final authUser = AuthUtils.requireRole(session, ['patient']);
    
    return await Appointment.db.find(
      session,
      where: (t) => t.patientId.equals(authUser.userId),
      include: Appointment.include(
        hospital: Hospital.include(),
        dentist: Dentist.include(),
      ),
      orderBy: (t) => t.date,
      orderDescending: true,
    );
  }

  /// Allows patient to cancel their pending appointment
  Future<Appointment> cancelPatientAppointment(Session session, int appointmentId) async {
    final authUser = AuthUtils.requireRole(session, ['patient']);
    
    final appointment = await Appointment.db.findById(session, appointmentId);
    if (appointment == null) {
      throw Exception('Appointment not found.');
    }
    
    if (appointment.patientId != authUser.userId) {
      throw Exception('Forbidden. You do not own this appointment.');
    }
    
    if (appointment.status != AppointmentStatus.pending) {
      throw Exception('Only pending appointments can be cancelled.');
    }
    
    appointment.status = AppointmentStatus.cancelled;
    appointment.updatedAt = DateTime.now();
    
    return await Appointment.db.updateRow(session, appointment);
  }

  /// Gets appointments for the authenticated receptionist's hospital
  Future<List<Appointment>> getHospitalAppointments(Session session) async {
    final authUser = AuthUtils.requireRole(session, ['receptionist']);
    
    if (authUser.hospitalId == null) {
      throw Exception('Forbidden. Receptionist does not belong to any hospital.');
    }
    
    return await Appointment.db.find(
      session,
      where: (t) => t.hospitalId.equals(authUser.hospitalId!),
      include: Appointment.include(
        patient: Patient.include(),
        dentist: Dentist.include(),
      ),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Gets details of a specific hospital appointment
  Future<Appointment?> getHospitalAppointmentDetails(Session session, int appointmentId) async {
    final authUser = AuthUtils.requireRole(session, ['receptionist']);
    
    final appointment = await Appointment.db.findById(
      session, 
      appointmentId,
      include: Appointment.include(
        patient: Patient.include(),
        dentist: Dentist.include(),
      )
    );
    
    if (appointment != null && appointment.hospitalId != authUser.hospitalId) {
      throw Exception('Forbidden. This appointment belongs to a different hospital.');
    }
    
    return appointment;
  }

  /// Gets available approved dentists for a specific appointment in the receptionist's hospital
  Future<List<Dentist>> getAvailableDentistsForAppointment(Session session) async {
    final authUser = AuthUtils.requireRole(session, ['receptionist']);
    
    if (authUser.hospitalId == null) {
      throw Exception('Forbidden. Receptionist does not belong to any hospital.');
    }

    return await Dentist.db.find(
      session,
      where: (t) => t.hospitalId.equals(authUser.hospitalId!) & t.status.equals(DentistStatus.approved),
    );
  }

  /// Allocates an approved dentist to a pending appointment
  Future<Appointment> allocateDentist(Session session, int appointmentId, int dentistId) async {
    final authUser = AuthUtils.requireRole(session, ['receptionist']);
    
    if (authUser.hospitalId == null) {
      throw Exception('Forbidden. Receptionist does not belong to any hospital.');
    }

    return await session.db.transaction((transaction) async {
      final appointment = await Appointment.db.findById(session, appointmentId);
      if (appointment == null) {
        throw Exception('Appointment not found.');
      }

      if (appointment.hospitalId != authUser.hospitalId) {
        throw Exception('Forbidden. Appointment belongs to a different hospital.');
      }

      if (appointment.status != AppointmentStatus.pending) {
        throw Exception('Only pending appointments can be allocated.');
      }

      if (appointment.dentistId != null) {
        throw Exception('Appointment is already allocated to a dentist.');
      }

      final dentist = await Dentist.db.findById(session, dentistId);
      if (dentist == null) {
        throw Exception('Dentist not found.');
      }

      if (dentist.hospitalId != authUser.hospitalId) {
        throw Exception('Forbidden. Dentist belongs to a different hospital.');
      }

      if (dentist.status != DentistStatus.approved) {
        throw Exception('Only approved dentists can be allocated.');
      }

      appointment.dentistId = dentist.id;
      appointment.status = AppointmentStatus.accepted;
      appointment.updatedAt = DateTime.now();

      return await Appointment.db.updateRow(session, appointment, transaction: transaction);
    });
  }

  /// Gets appointments allocated to the authenticated dentist
  Future<List<Appointment>> getDentistAppointments(Session session) async {
    final authUser = AuthUtils.requireRole(session, ['dentist']);
    
    return await Appointment.db.find(
      session,
      where: (t) => t.dentistId.equals(authUser.userId),
      include: Appointment.include(
        patient: Patient.include(),
        hospital: Hospital.include(),
      ),
      orderBy: (t) => t.date,
    );
  }
}
