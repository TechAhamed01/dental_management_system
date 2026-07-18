import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui_web' as ui_web;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dental_client/dental_client.dart';
import '../providers/dashboard_provider.dart';
import 'theme.dart';

void showDentistDetailsDialog(
  BuildContext context,
  Dentist dentist,
  DashboardProvider provider, {
  bool readOnly = false,
}) {
  showDialog(
    context: context,
    builder: (ctx) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          width: 850,
          constraints: const BoxConstraints(maxHeight: 750),
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                        child: const Icon(Icons.person, color: AppTheme.primaryColor),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. ${dentist.fullName}',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '${dentist.specialization} • ${dentist.clinicName}',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getStatusColor(dentist.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          dentist.status.name.toUpperCase(),
                          style: TextStyle(
                            color: _getStatusColor(dentist.status),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeading('Basic Information'),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 5,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildDetailItem('Full Name', dentist.fullName),
                            _buildDetailItem('Email', dentist.email),
                            _buildDetailItem('Phone Number', dentist.phone),
                            _buildDetailItem('Date of Birth', dentist.dateOfBirth ?? 'Not provided'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildSectionHeading('Professional Information'),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildDetailItem('Registration Number', dentist.licenseNumber),
                            _buildDetailItem('Specialization', dentist.specialization),
                            _buildDetailItem('Qualification', dentist.qualification ?? 'Not provided'),
                            _buildDetailItem('Experience', '${dentist.experience} years'),
                            _buildDetailItem('Clinic / Hospital', dentist.clinicName),
                            _buildDetailItem('Clinic Address', dentist.clinicAddress),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildSectionHeading('Verification Documents (Uploaded)'),
                      const SizedBox(height: 12),
                      _buildDocumentCard(context, 'Medical Registration Certificate', dentist.registrationFileUrl),
                      const SizedBox(height: 16),
                      _buildDocumentCard(context, 'Degree Certificate', dentist.degreeFileUrl),
                      const SizedBox(height: 16),
                      _buildDocumentCard(context, 'Government ID', dentist.idFileUrl),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Close'),
                  ),
                  if (!readOnly && dentist.status == DentistStatus.pending) ...[
                    const SizedBox(width: 16),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.errorColor,
                        side: const BorderSide(color: AppTheme.errorColor),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('Reject Application'),
                      onPressed: () {
                        Navigator.pop(ctx);
                        _showConfirmationDialog(context, 'Reject', dentist, () {
                          provider.rejectDentist(dentist.id!);
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.successColor,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      ),
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Approve Application'),
                      onPressed: () {
                        Navigator.pop(ctx);
                        _showConfirmationDialog(context, 'Approve', dentist, () {
                          provider.approveDentist(dentist.id!);
                        });
                      },
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Color _getStatusColor(DentistStatus status) {
  switch (status) {
    case DentistStatus.approved:
      return AppTheme.successColor;
    case DentistStatus.rejected:
      return AppTheme.errorColor;
    case DentistStatus.pending:
      return Colors.amber.shade800;
  }
}

void _showConfirmationDialog(BuildContext context, String action, Dentist dentist, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('$action Dentist'),
      content: Text('Are you sure you want to $action Dr. ${dentist.fullName}?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: action == 'Approve' ? AppTheme.successColor : AppTheme.errorColor,
          ),
          onPressed: () {
            Navigator.pop(ctx);
            onConfirm();
          },
          child: Text(action),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeading(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppTheme.primaryColor,
    ),
  );
}

Widget _buildDetailItem(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary),
      ),
      const SizedBox(height: 4),
      Text(
        value.isEmpty ? 'Not provided' : value,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

Widget _buildDocumentCard(BuildContext context, String title, String? rawData) {
  if (rawData == null || rawData.isEmpty) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.amber.shade700),
          const SizedBox(width: 12),
          Text(
            '$title: No document uploaded',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  String fileName = 'Document';
  String? dataUrl;

  if (rawData.contains('|data:')) {
    final parts = rawData.split('|data:');
    fileName = parts[0];
    dataUrl = 'data:${parts[1]}';
  } else if (rawData.startsWith('data:')) {
    fileName = '$title File';
    dataUrl = rawData;
  } else {
    fileName = rawData;
    dataUrl = null;
  }

  Uint8List? imageBytes;
  Uint8List? pdfBytes;
  bool isPdf = false;

  if (dataUrl != null) {
    if (dataUrl.startsWith('data:image/')) {
      try {
        final base64Part = dataUrl.split(',').last;
        imageBytes = base64Decode(base64Part);
      } catch (e) {
        debugPrint('Error decoding image bytes: $e');
      }
    } else if (dataUrl.startsWith('data:application/pdf')) {
      isPdf = true;
      try {
        final base64Part = dataUrl.split(',').last;
        pdfBytes = base64Decode(base64Part);
      } catch (e) {
        debugPrint('Error decoding pdf bytes: $e');
      }
    }
  } else if (fileName.toLowerCase().endsWith('.png') ||
      fileName.toLowerCase().endsWith('.jpg') ||
      fileName.toLowerCase().endsWith('.jpeg')) {
  } else if (fileName.toLowerCase().endsWith('.pdf')) {
    isPdf = true;
  }

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: const Color(0xFFE2E8F0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              isPdf ? Icons.picture_as_pdf : Icons.image,
              color: isPdf ? Colors.red : AppTheme.primaryColor,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    fileName,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (imageBytes != null)
              TextButton.icon(
                icon: const Icon(Icons.fullscreen, size: 18),
                label: const Text('Fullscreen Preview'),
                onPressed: () => _showFullscreenImage(context, imageBytes!, title),
              )
            else if (isPdf && (pdfBytes != null || dataUrl != null))
              TextButton.icon(
                icon: const Icon(Icons.fullscreen, size: 18),
                label: const Text('Fullscreen Preview'),
                onPressed: () => _showFullscreenPdf(context, pdfBytes, dataUrl, fileName, title),
              ),
          ],
        ),
        if (imageBytes != null) ...[
          const SizedBox(height: 14),
          Container(
            height: 220,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(imageBytes, fit: BoxFit.contain),
            ),
          ),
        ] else if (isPdf) ...[
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.picture_as_pdf, color: Colors.red, size: 36),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fileName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 16),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'PDF Document verified securely in database.',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                if (pdfBytes != null || dataUrl != null)
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text('Preview PDF', style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () => _showFullscreenPdf(context, pdfBytes, dataUrl, fileName, title),
                  ),
              ],
            ),
          ),
        ],
      ],
    ),
  );
}

void _showFullscreenImage(BuildContext context, Uint8List bytes, String title) {
  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.all(20),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.memory(bytes),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(ctx),
            ),
          ),
        ],
      ),
    ),
  );
}

void _showFullscreenPdf(
  BuildContext context,
  Uint8List? pdfBytes,
  String? dataUrl,
  String fileName,
  String title,
) {
  if (!kIsWeb) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PDF preview is currently supported on Web.')),
    );
    return;
  }

  String url = '';
  if (pdfBytes != null) {
    try {
      final blob = html.Blob([pdfBytes], 'application/pdf');
      url = html.Url.createObjectUrlFromBlob(blob);
    } catch (e) {
      debugPrint('Error creating Blob URL: $e');
      url = dataUrl ?? '';
    }
  } else if (dataUrl != null) {
    url = dataUrl;
  }

  if (url.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Unable to load PDF data for preview.')),
    );
    return;
  }

  final viewId = 'pdf-viewer-${DateTime.now().millisecondsSinceEpoch}';
  try {
    ui_web.platformViewRegistry.registerViewFactory(
      viewId,
      (int id) => html.IFrameElement()
        ..src = url
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%',
    );
  } catch (e) {
    debugPrint('Error registering view factory: $e');
  }

  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 900,
        height: 750,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.picture_as_pdf, color: Colors.red, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$title Preview',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        fileName,
                        style: const TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.open_in_new, size: 18),
                  label: const Text('Open in Browser Tab'),
                  onPressed: () {
                    html.window.open(url, '_blank');
                  },
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text('Download'),
                  onPressed: () {
                    final anchor = html.AnchorElement(href: url)
                      ..setAttribute('download', fileName)
                      ..click();
                  },
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.close, size: 24),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: HtmlElementView(viewType: viewId),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
