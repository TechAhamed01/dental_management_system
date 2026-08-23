import 'dart:io';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

class DocumentStorageService {
  static const String _baseStorageDir = '.storage/dentist_documents';

  /// Uploads a document and returns the secure storage key
  static Future<String> uploadDocument({
    required int dentistId,
    required String documentType,
    required ByteData bytes,
  }) async {
    final uuid = const Uuid().v4();
    final storageKey = 'dentists/$dentistId/$documentType/$uuid';
    
    final file = File(p.join(_baseStorageDir, storageKey));
    
    // Ensure parent directories exist
    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }
    
    // Write bytes to file
    await file.writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    
    return storageKey;
  }

  /// Downloads a document given a storage key
  static Future<ByteData?> downloadDocument(String storageKey) async {
    // Validate storageKey to prevent path traversal
    if (storageKey.contains('..') || storageKey.startsWith('/')) {
      return null;
    }
    
    final file = File(p.join(_baseStorageDir, storageKey));
    if (await file.exists()) {
      final bytes = await file.readAsBytes();
      return bytes.buffer.asByteData();
    }
    return null;
  }

  /// Deletes a document given a storage key
  static Future<void> deleteDocument(String storageKey) async {
    if (storageKey.contains('..') || storageKey.startsWith('/')) {
      return;
    }
    
    final file = File(p.join(_baseStorageDir, storageKey));
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Checks if a document exists
  static Future<bool> documentExists(String storageKey) async {
    if (storageKey.contains('..') || storageKey.startsWith('/')) {
      return false;
    }
    final file = File(p.join(_baseStorageDir, storageKey));
    return await file.exists();
  }

  // --- Dental Image Storage Methods ---

  static const String _dentalImagesDir = '.storage/dental_images';

  /// Uploads a dental image and returns the secure storage key
  static Future<String> uploadDentalImage({
    required int patientId,
    required int appointmentId,
    required ByteData bytes,
  }) async {
    final uuid = const Uuid().v4();
    final storageKey = 'patients/$patientId/appointments/$appointmentId/$uuid';
    
    final file = File(p.join(_dentalImagesDir, storageKey));
    
    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }
    
    await file.writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    
    return storageKey;
  }

  /// Downloads a dental image given a storage key
  static Future<ByteData?> downloadDentalImage(String storageKey) async {
    if (storageKey.contains('..') || storageKey.startsWith('/')) {
      return null;
    }
    
    final file = File(p.join(_dentalImagesDir, storageKey));
    if (await file.exists()) {
      final bytes = await file.readAsBytes();
      return bytes.buffer.asByteData();
    }
    return null;
  }

  /// Deletes a dental image given a storage key
  static Future<void> deleteDentalImage(String storageKey) async {
    if (storageKey.contains('..') || storageKey.startsWith('/')) {
      return;
    }
    
    final file = File(p.join(_dentalImagesDir, storageKey));
    if (await file.exists()) {
      await file.delete();
    }
  }
}
