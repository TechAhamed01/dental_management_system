import 'dart:typed_data';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils/auth_utils.dart';
import '../services/document_storage_service.dart';

class DentalImageEndpoint extends Endpoint {
  
  /// Uploads a dental image for an appointment
  Future<DentalImage> uploadDentalImage(
    Session session, 
    int appointmentId, 
    String fileName, 
    String mimeType, 
    ByteData imageData
  ) async {
    // 1. Authenticate & Authorize
    final authUser = AuthUtils.requireRole(session, ['dentist']);
    
    // 2. Fetch the appointment
    final appointment = await Appointment.db.findById(session, appointmentId);
    if (appointment == null) {
      throw Exception('Appointment not found.');
    }
    
    // 3. Verify ownership & status
    if (appointment.dentistId != authUser.userId) {
      throw Exception('Forbidden. You can only upload images for your own appointments.');
    }
    if (appointment.status != AppointmentStatus.accepted) {
      throw Exception('Forbidden. You can only upload images for accepted appointments.');
    }
    
    // 4. Validate file size (10 MB limit)
    final fileSize = imageData.lengthInBytes;
    const int maxSizeBytes = 10 * 1024 * 1024;
    if (fileSize > maxSizeBytes) {
      throw Exception('File size exceeds the 10 MB limit.');
    }
    
    // 5. Validate MIME type
    final allowedMimeTypes = ['image/jpeg', 'image/png', 'image/webp'];
    if (!allowedMimeTypes.contains(mimeType)) {
      throw Exception('Unsupported file type. Allowed types: JPEG, PNG, WebP.');
    }
    
    // 6. Upload binary file
    final storageKey = await DocumentStorageService.uploadDentalImage(
      patientId: appointment.patientId,
      appointmentId: appointmentId,
      bytes: imageData,
    );
    
    // 7. Create database record
    try {
      final dentalImage = DentalImage(
        patientId: appointment.patientId,
        appointmentId: appointmentId,
        dentistId: authUser.userId,
        fileName: fileName,
        mimeType: mimeType,
        storageKey: storageKey,
        fileSize: fileSize,
        uploadedAt: DateTime.now(),
      );
      
      final createdRecord = await DentalImage.db.insertRow(session, dentalImage);
      return createdRecord;
    } catch (e) {
      // Cleanup file if DB insert fails
      await DocumentStorageService.deleteDentalImage(storageKey);
      throw Exception('Failed to save image metadata: $e');
    }
  }

  /// Gets all dental images for a specific appointment
  Future<List<DentalImage>> getDentalImagesForAppointment(Session session, int appointmentId) async {
    final authUser = AuthUtils.requireRole(session, ['dentist']);
    
    final appointment = await Appointment.db.findById(session, appointmentId);
    if (appointment == null) {
      throw Exception('Appointment not found.');
    }
    
    if (appointment.dentistId != authUser.userId) {
      throw Exception('Forbidden. You can only view images for your own appointments.');
    }
    
    return await DentalImage.db.find(
      session,
      where: (t) => t.appointmentId.equals(appointmentId),
      orderBy: (t) => t.uploadedAt,
      orderDescending: true,
    );
  }

  /// Downloads a dental image securely
  Future<ByteData> downloadDentalImage(Session session, int dentalImageId) async {
    final authUser = AuthUtils.requireRole(session, ['dentist']);
    
    final imageMetadata = await DentalImage.db.findById(session, dentalImageId);
    if (imageMetadata == null) {
      throw Exception('Dental image not found.');
    }
    
    if (imageMetadata.dentistId != authUser.userId) {
      throw Exception('Forbidden. You can only download your own uploaded images.');
    }
    
    final bytes = await DocumentStorageService.downloadDentalImage(imageMetadata.storageKey);
    if (bytes == null) {
      throw Exception('File not found in storage.');
    }
    
    return bytes;
  }
}
