import 'dart:typed_data';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/document_storage_service.dart';
import '../utils/auth_utils.dart';

class DocumentEndpoint extends Endpoint {
  /// Fetches the metadata of documents for a specific dentist.
  /// Enforces authorization:
  /// - Admin: All access
  /// - Dentist: Only their own
  /// - Receptionist: Only dentists in their hospital
  Future<List<DentistDocument>> getDentistDocuments(Session session, int dentistId) async {
    final user = AuthUtils.getAuthenticatedUser(session);
    if (user == null) {
      throw Exception('Unauthorized.');
    }

    if (user.role == 'patient') {
      throw Exception('Forbidden. Patients cannot access dentist documents.');
    }

    final targetDentist = await Dentist.db.findById(session, dentistId);
    if (targetDentist == null) {
      throw Exception('Dentist not found.');
    }

    // Role-based authorization
    if (user.role == 'dentist') {
      if (user.userId != dentistId) {
        throw Exception('Forbidden. You can only access your own documents.');
      }
    } else if (user.role == 'receptionist') {
      if (user.hospitalId == null || targetDentist.hospitalId != user.hospitalId) {
        throw Exception('Forbidden. You do not have access to this dentist\'s documents.');
      }
    } else if (user.role == 'admin') {
      // Admin has full access
    } else {
      throw Exception('Forbidden. Invalid role.');
    }

    final documents = await DentistDocument.db.find(
      session,
      where: (t) => t.dentistId.equals(dentistId),
    );

    return documents;
  }

  /// Securely downloads a document's binary data given its metadata ID.
  Future<ByteData?> downloadDocument(Session session, int documentId) async {
    final user = AuthUtils.getAuthenticatedUser(session);
    if (user == null) {
      throw Exception('Unauthorized.');
    }

    if (user.role == 'patient') {
      throw Exception('Forbidden. Patients cannot access dentist documents.');
    }

    final document = await DentistDocument.db.findById(session, documentId, include: DentistDocument.include(dentist: Dentist.include()));
    if (document == null) {
      throw Exception('Document not found.');
    }

    final targetDentist = document.dentist;
    if (targetDentist == null) {
      throw Exception('Dentist not found for document.');
    }

    // Role-based authorization
    if (user.role == 'dentist') {
      if (user.userId != targetDentist.id) {
        throw Exception('Forbidden. You can only download your own documents.');
      }
    } else if (user.role == 'receptionist') {
      if (user.hospitalId == null || targetDentist.hospitalId != user.hospitalId) {
        throw Exception('Forbidden. You do not have access to this dentist\'s documents.');
      }
    } else if (user.role == 'admin') {
      // Admin has full access
    } else {
      throw Exception('Forbidden. Invalid role.');
    }

    final bytes = await DocumentStorageService.downloadDocument(document.storageKey);
    if (bytes == null) {
      throw Exception('Document file not found on server.');
    }

    return bytes;
  }
}
