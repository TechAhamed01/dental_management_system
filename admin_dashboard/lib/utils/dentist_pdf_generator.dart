import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdf/pdf.dart' as sf;
import 'package:dental_client/dental_client.dart';
import '../providers/dashboard_provider.dart';
import '../services/serverpod_client.dart';

class _ParsedDoc {
  final String title;
  final String fileName;
  final bool isUploaded;
  final bool isPdf;
  final Uint8List? imageBytes;
  final Uint8List? pdfBytes;

  _ParsedDoc({
    required this.title,
    required this.fileName,
    required this.isUploaded,
    required this.isPdf,
    this.imageBytes,
    this.pdfBytes,
  });
}

String _cleanText(String? text) {
  if (text == null || text.isEmpty) return 'Not provided';
  return text
      .replaceAll('•', '-')
      .replaceAll('–', '-')
      .replaceAll('—', '-')
      .replaceAll('’', "'")
      .replaceAll('‘', "'")
      .replaceAll('“', '"')
      .replaceAll('”', '"')
      .replaceAll('\u00A0', ' ')
      .replaceAll('\u200B', '')
      .replaceAll('\u200C', '')
      .replaceAll('\u200D', '')
      .replaceAll(RegExp(r'[^\x20-\x7E\r\n\t]'), '');
}

Future<_ParsedDoc> _parseDocument(String title, String? rawData) async {
  if (rawData == null || rawData.isEmpty) {
    return _ParsedDoc(
      title: title,
      fileName: 'Not Uploaded',
      isUploaded: false,
      isPdf: false,
    );
  }

  String fileName = 'Document';
  String? dataUrl;
  Uint8List? rawBytes;

  if (rawData.startsWith('[SECURE_DOCUMENT:')) {
    try {
      final endIndex = rawData.indexOf(']');
      if (endIndex != -1) {
        final idStr = rawData.substring(17, endIndex);
        final docId = int.parse(idStr);
        final byteData = await client.document.downloadDocument(docId);
        if (byteData != null) {
          rawBytes = byteData.buffer.asUint8List();
          fileName = '$title (Secure Document)';
        }
      }
    } catch (e) {
      debugPrint('Error fetching secure document for PDF: $e');
    }
  } else if (rawData.contains('|data:')) {
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

  if (rawBytes != null) {
    if (rawBytes.length >= 4 &&
        rawBytes[0] == 0x25 &&
        rawBytes[1] == 0x50 &&
        rawBytes[2] == 0x44 &&
        rawBytes[3] == 0x46) {
      isPdf = true;
      pdfBytes = rawBytes;
      fileName = '$title File.pdf';
    } else if (rawBytes.length >= 4) {
      imageBytes = rawBytes;
      fileName = '$title File.png';
    }
  } else if (dataUrl != null) {
    if (dataUrl.startsWith('data:image/')) {
      try {
        final base64Part = dataUrl.split(',').last;
        imageBytes = base64Decode(base64Part);
      } catch (e) {
        debugPrint('Error decoding image bytes for PDF: $e');
      }
    } else if (dataUrl.startsWith('data:application/pdf')) {
      isPdf = true;
      try {
        final base64Part = dataUrl.split(',').last;
        pdfBytes = base64Decode(base64Part);
      } catch (e) {
        debugPrint('Error decoding pdf bytes for PDF: $e');
      }
    } else {
      try {
        final base64Part = dataUrl.split(',').last;
        final decoded = base64Decode(base64Part);
        if (decoded.length >= 4 &&
            decoded[0] == 0x25 &&
            decoded[1] == 0x50 &&
            decoded[2] == 0x44 &&
            decoded[3] == 0x46) {
          isPdf = true;
          pdfBytes = decoded;
        } else {
          imageBytes = decoded;
        }
      } catch (e) {
        debugPrint('Error decoding fallback dataUrl: $e');
      }
    }
  } else {
    if (fileName.toLowerCase().endsWith('.pdf')) {
      isPdf = true;
    } else if (!fileName.toLowerCase().endsWith('.png') &&
               !fileName.toLowerCase().endsWith('.jpg') &&
               !fileName.toLowerCase().endsWith('.jpeg')) {
      try {
        final decoded = base64Decode(fileName);
        if (decoded.length >= 4 &&
            decoded[0] == 0x25 &&
            decoded[1] == 0x50 &&
            decoded[2] == 0x44 &&
            decoded[3] == 0x46) {
          isPdf = true;
          pdfBytes = decoded;
          fileName = '$title File.pdf';
        } else if (decoded.length >= 4) {
          imageBytes = decoded;
          fileName = '$title File.png';
        }
      } catch (e) {
        // Not raw base64, just a normal filename path
      }
    }
  }

  return _ParsedDoc(
    title: title,
    fileName: _cleanText(fileName),
    isUploaded: rawBytes != null || dataUrl != null || imageBytes != null || pdfBytes != null,
    isPdf: isPdf,
    imageBytes: imageBytes,
    pdfBytes: pdfBytes,
  );
}

Future<void> generateAndDownloadDentistPdf(BuildContext context, Dentist dentist) async {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Row(
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          ),
          SizedBox(width: 12),
          Text('Compiling complete details & merging attached certificates...'),
        ],
      ),
      duration: Duration(seconds: 3),
    ),
  );

  if (context.mounted && dentist.id != null) {
    context.read<DashboardProvider>().logPdfDownload(dentist.id!);
  }

  try {
    final pdf = pw.Document();

    final parsedDocs = [
      await _parseDocument('Medical Registration Certificate', dentist.registrationFileUrl),
      await _parseDocument('Degree Certificate', dentist.degreeFileUrl),
      await _parseDocument('Government ID', dentist.idFileUrl),
    ];

    final primaryColor = PdfColor.fromHex('#1E3A8A'); // Deep Blue
    final secondaryColor = PdfColor.fromHex('#475569'); // Slate
    final lightBgColor = PdfColor.fromHex('#F8FAFC');
    final borderColor = PdfColor.fromHex('#E2E8F0');

    PdfColor statusBgColor;
    PdfColor statusTextColor;
    switch (dentist.status) {
      case DentistStatus.approved:
        statusBgColor = PdfColor.fromHex('#DCFCE7');
        statusTextColor = PdfColor.fromHex('#166534');
        break;
      case DentistStatus.rejected:
        statusBgColor = PdfColor.fromHex('#FEE2E2');
        statusTextColor = PdfColor.fromHex('#991B1B');
        break;
      case DentistStatus.pending:
        statusBgColor = PdfColor.fromHex('#FEF3C7');
        statusTextColor = PdfColor.fromHex('#92400E');
        break;
      case DentistStatus.suspended:
        statusBgColor = PdfColor.fromHex('#FFEDD5');
        statusTextColor = PdfColor.fromHex('#C2410C');
        break;
      case DentistStatus.terminated:
        statusBgColor = PdfColor.fromHex('#FEE2E2');
        statusTextColor = PdfColor.fromHex('#991B1B');
        break;
    }

    final cleanedFullName = _cleanText(dentist.fullName);
    final cleanedSpecialization = _cleanText(dentist.specialization);
    final cleanedClinicName = _cleanText(dentist.clinicName);
    final cleanedClinicAddress = _cleanText(dentist.clinicAddress);
    final cleanedQualification = _cleanText(dentist.qualification);
    final cleanedEmail = _cleanText(dentist.email);
    final cleanedPhone = _cleanText(dentist.phone);
    final cleanedLicenseNumber = _cleanText(dentist.licenseNumber);
    final cleanedDob = _cleanText(dentist.dateOfBirth);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(36),
        theme: pw.ThemeData.withFont(
          base: pw.Font.helvetica(),
          bold: pw.Font.helveticaBold(),
          italic: pw.Font.helveticaOblique(),
          boldItalic: pw.Font.helveticaBoldOblique(),
        ),
        header: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'DentalCare Admin Portal',
                        style: pw.TextStyle(
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'DENTIST APPLICATION & VERIFICATION REPORT',
                        style: pw.TextStyle(
                          color: secondaryColor,
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: pw.BoxDecoration(
                          color: statusBgColor,
                          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
                        ),
                        child: pw.Text(
                          'STATUS: ${dentist.status.name.toUpperCase()}',
                          style: pw.TextStyle(
                            color: statusTextColor,
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        'Generated: ${DateTime.now().toString().split('.').first}',
                        style: pw.TextStyle(color: secondaryColor, fontSize: 9),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 12),
              pw.Divider(color: borderColor, thickness: 1.5),
              pw.SizedBox(height: 16),
            ],
          );
        },
        footer: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Divider(color: borderColor, thickness: 1),
              pw.SizedBox(height: 6),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Confidential - DentalCare Verification System',
                    style: pw.TextStyle(color: secondaryColor, fontSize: 9),
                  ),
                  pw.Text(
                    'Page ${context.pageNumber} of ${context.pagesCount}',
                    style: pw.TextStyle(color: secondaryColor, fontSize: 9),
                  ),
                ],
              ),
            ],
          );
        },
        build: (pw.Context context) {
          return [
            // Profile Overview Header Card
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                color: lightBgColor,
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                border: pw.Border.all(color: borderColor),
              ),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Dr. $cleanedFullName ${dentist.dentistCode != null ? '(${dentist.dentistCode})' : ''}',
                          style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        pw.SizedBox(height: 4),
                        pw.Text(
                          '$cleanedSpecialization - $cleanedClinicName',
                          style: pw.TextStyle(fontSize: 12, color: secondaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // Section 1: Basic Information
            _buildSectionHeader('1. Basic Information', primaryColor),
            pw.SizedBox(height: 8),
            _buildInfoTable([
              ['Full Name', 'Dr. $cleanedFullName'],
              ['Email Address', cleanedEmail],
              ['Phone Number', cleanedPhone],
              ['Date of Birth', cleanedDob],
            ], borderColor, lightBgColor),
            pw.SizedBox(height: 20),

            // Section 2: Professional Information
            _buildSectionHeader('2. Professional Information', primaryColor),
            pw.SizedBox(height: 8),
            _buildInfoTable([
              ['Registration Number', cleanedLicenseNumber],
              ['Specialization', cleanedSpecialization],
              ['Qualification', cleanedQualification],
              ['Experience', '${dentist.experience} years'],
              ['Clinic / Hospital Name', cleanedClinicName],
              ['Clinic Address', cleanedClinicAddress],
            ], borderColor, lightBgColor),
            pw.SizedBox(height: 20),

            if (dentist.status == DentistStatus.suspended) ...[
              _buildSectionHeader('Suspension Details', PdfColor.fromHex('#C2410C')),
              pw.SizedBox(height: 8),
              _buildInfoTable([
                ['Suspended Until', dentist.suspensionEndsAt?.toString().split(' ')[0] ?? 'N/A'],
                ['Reason', _cleanText(dentist.suspensionReason)],
              ], borderColor, PdfColor.fromHex('#FFF7ED')),
              pw.SizedBox(height: 20),
            ],
            if (dentist.status == DentistStatus.terminated) ...[
              _buildSectionHeader('Termination Details', PdfColor.fromHex('#991B1B')),
              pw.SizedBox(height: 8),
              _buildInfoTable([
                ['Terminated On', dentist.terminatedAt?.toString().split(' ')[0] ?? 'N/A'],
                ['Reason', _cleanText(dentist.terminationReason)],
              ], borderColor, PdfColor.fromHex('#FEF2F2')),
              pw.SizedBox(height: 20),
            ],

            // Section 3: Verification Documents Summary
            _buildSectionHeader('3. Verification Documents Overview', primaryColor),
            pw.SizedBox(height: 8),
            _buildDocumentsSummaryTable(parsedDocs, borderColor, lightBgColor),
          ];
        },
      ),
    );

    // Section 4: Attached Images (if any uploaded as image bytes)
    final imageDocs = parsedDocs.where((d) => d.imageBytes != null).toList();
    if (imageDocs.isNotEmpty) {
      for (final doc in imageDocs) {
        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            margin: const pw.EdgeInsets.all(36),
            build: (pw.Context context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Attachment (Image): ${doc.title}',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'File Name: ${doc.fileName}',
                    style: pw.TextStyle(fontSize: 11, color: secondaryColor),
                  ),
                  pw.SizedBox(height: 12),
                  pw.Divider(color: borderColor, thickness: 1),
                  pw.SizedBox(height: 16),
                  pw.Expanded(
                    child: pw.Center(
                      child: pw.Image(
                        pw.MemoryImage(doc.imageBytes!),
                        fit: pw.BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }
    }

    // Save our generated profile summary report & image pages from package:pdf
    final Uint8List reportBytes = await pdf.save();

    // Section 5: Merge attached PDF files using Syncfusion sections with strict isolation & source retention
    final pdfDocs = parsedDocs.where((d) => d.isPdf && d.pdfBytes != null).toList();
    List<int> finalPdfBytes = reportBytes;

    if (pdfDocs.isNotEmpty) {
      final sf.PdfDocument masterDocument = sf.PdfDocument();
      final List<sf.PdfDocument> docsToDispose = [];

      // 1. Import all pages from our primary report using isolated sections
      try {
        final sf.PdfDocument reportDoc = sf.PdfDocument(inputBytes: reportBytes);
        docsToDispose.add(reportDoc);
        for (int i = 0; i < reportDoc.pages.count; i++) {
          final sf.PdfPage sourcePage = reportDoc.pages[i];
          final sf.PdfTemplate template = sourcePage.createTemplate();
          final sf.PdfSection section = masterDocument.sections!.add();
          section.pageSettings.size = sourcePage.size;
          section.pageSettings.margins.all = 0;
          final sf.PdfPage newPage = section.pages.add();
          newPage.graphics.drawPdfTemplate(
            template,
            const Offset(0, 0),
            sourcePage.size,
          );
        }
      } catch (e) {
        debugPrint('Error importing primary report pages: $e');
      }

      // 2. Import all pages from each attached PDF certificate (Degree Certificate, Government ID, etc.)
      for (final doc in pdfDocs) {
        try {
          final sf.PdfDocument attachedPdf = sf.PdfDocument(inputBytes: doc.pdfBytes!);
          docsToDispose.add(attachedPdf);
          for (int i = 0; i < attachedPdf.pages.count; i++) {
            final sf.PdfPage sourcePage = attachedPdf.pages[i];
            final sf.PdfTemplate template = sourcePage.createTemplate();
            final sf.PdfSection section = masterDocument.sections!.add();
            section.pageSettings.size = sourcePage.size;
            section.pageSettings.margins.all = 0;
            final sf.PdfPage newPage = section.pages.add();
            newPage.graphics.drawPdfTemplate(
              template,
              const Offset(0, 0),
              sourcePage.size,
            );
          }
        } catch (e) {
          debugPrint('Error merging attached PDF (${doc.title}): $e');
        }
      }

      finalPdfBytes = masterDocument.saveSync();
      masterDocument.dispose();

      for (final doc in docsToDispose) {
        doc.dispose();
      }
    }

    final Uint8List uint8Bytes = finalPdfBytes is Uint8List
        ? finalPdfBytes
        : Uint8List.fromList(finalPdfBytes);
    final blob = html.Blob([uint8Bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final safeName = _cleanText(dentist.fullName).replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
    final fileNameCode = dentist.dentistCode != null ? '${dentist.dentistCode}_' : '${safeName}_';
    html.AnchorElement(href: url)
      ..setAttribute('download', '${fileNameCode}Application.pdf')
      ..click();
    html.Url.revokeObjectUrl(url);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complete Details & Attached Documents PDF downloaded successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 4),
        ),
      );
    }
  } catch (e, stack) {
    debugPrint('Error generating PDF: $e\n$stack');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to generate PDF: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

pw.Widget _buildSectionHeader(String title, PdfColor color) {
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 8),
    decoration: pw.BoxDecoration(
      border: pw.Border(left: pw.BorderSide(color: color, width: 4)),
    ),
    child: pw.Text(
      _cleanText(title),
      style: pw.TextStyle(
        fontSize: 14,
        fontWeight: pw.FontWeight.bold,
        color: color,
      ),
    ),
  );
}

pw.Widget _buildInfoTable(
  List<List<String>> rows,
  PdfColor borderColor,
  PdfColor lightBgColor,
) {
  return pw.Table(
    border: pw.TableBorder.all(color: borderColor, width: 0.5),
    columnWidths: {
      0: const pw.FlexColumnWidth(2),
      1: const pw.FlexColumnWidth(3),
    },
    children: rows.map((row) {
      final isEven = rows.indexOf(row) % 2 == 0;
      return pw.TableRow(
        decoration: pw.BoxDecoration(
          color: isEven ? lightBgColor : PdfColors.white,
        ),
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: pw.Text(
              _cleanText(row[0]),
              style: pw.TextStyle(
                fontSize: 10,
                fontWeight: pw.FontWeight.bold,
                color: PdfColor.fromHex('#334155'),
              ),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: pw.Text(
              _cleanText(row[1]),
              style: const pw.TextStyle(fontSize: 10),
            ),
          ),
        ],
      );
    }).toList(),
  );
}

pw.Widget _buildDocumentsSummaryTable(
  List<_ParsedDoc> docs,
  PdfColor borderColor,
  PdfColor lightBgColor,
) {
  return pw.Table(
    border: pw.TableBorder.all(color: borderColor, width: 0.5),
    columnWidths: {
      0: const pw.FlexColumnWidth(2.5),
      1: const pw.FlexColumnWidth(2.5),
      2: const pw.FlexColumnWidth(1.5),
    },
    children: [
      // Table Header
      pw.TableRow(
        decoration: pw.BoxDecoration(color: PdfColor.fromHex('#E2E8F0')),
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: pw.Text('Document Type', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: pw.Text('File Name / Description', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: pw.Text('Verification Status', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          ),
        ],
      ),
      ...docs.map((doc) {
        String statusText = doc.isUploaded ? 'Verified (Uploaded)' : 'Missing';
        PdfColor statusColor = doc.isUploaded ? PdfColor.fromHex('#166534') : PdfColor.fromHex('#991B1B');

        String desc = doc.fileName;
        if (doc.imageBytes != null) {
          desc += ' (Image Embedded Below)';
        } else if (doc.isPdf && doc.pdfBytes != null) {
          desc += ' (PDF Merged Below)';
        } else if (doc.isPdf) {
          desc += ' (PDF Document)';
        }

        return pw.TableRow(
          children: [
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: pw.Text(_cleanText(doc.title), style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: pw.Text(_cleanText(desc), style: const pw.TextStyle(fontSize: 10)),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: pw.Text(
                statusText,
                style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: statusColor),
              ),
            ),
          ],
        );
      }),
    ],
  );
}
