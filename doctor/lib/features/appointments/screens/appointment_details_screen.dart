import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dental_client/dental_client.dart';
import 'dart:typed_data';
import '../../../services/serverpod_client.dart';
import 'package:http/http.dart' as http;
import 'package:file_saver/file_saver.dart';

class DentistAppointmentDetailsScreen extends StatefulWidget {
  final Appointment appointment;

  const DentistAppointmentDetailsScreen({super.key, required this.appointment});

  @override
  State<DentistAppointmentDetailsScreen> createState() => _DentistAppointmentDetailsScreenState();
}

class _DentistAppointmentDetailsScreenState extends State<DentistAppointmentDetailsScreen> {
  List<DentalImage> _dentalImages = [];
  bool _isLoadingImages = true;
  bool _isUploading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchDentalImages();
  }

  Future<void> _fetchDentalImages() async {
    setState(() {
      _isLoadingImages = true;
      _errorMessage = null;
    });

    try {
      final images = await client.dentalImage.getDentalImagesForAppointment(widget.appointment.id!);
      setState(() {
        _dentalImages = images;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    } finally {
      setState(() {
        _isLoadingImages = false;
      });
    }
  }

  Future<void> _uploadImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      
      // Basic validation on frontend before sending
      if (file.size > 10 * 1024 * 1024) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File exceeds 10MB limit.')),
        );
        return;
      }
      
      String mimeType = 'image/jpeg';
      if (file.extension?.toLowerCase() == 'png') mimeType = 'image/png';
      if (file.extension?.toLowerCase() == 'webp') mimeType = 'image/webp';

      setState(() {
        _isUploading = true;
      });

      await client.dentalImage.uploadDentalImage(
        widget.appointment.id!,
        file.name,
        mimeType,
        file.bytes!.buffer.asByteData(),
      );

      // Simulate sending to CNN model via FastAPI backend
      try {
        final request = http.MultipartRequest(
          'POST',
          Uri.parse('http://localhost:8000/analyze'),
        );
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          file.bytes!,
          filename: file.name,
        ));
        
        final response = await request.send();
        
        if (response.statusCode == 200) {
          final pdfBytes = await response.stream.toBytes();
          
          await FileSaver.instance.saveFile(
            name: 'analysis_report_${file.name.split('.').first}',
            bytes: pdfBytes,
            ext: 'pdf',
            mimeType: MimeType.pdf,
          );
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('AI Analysis Report generated and downloaded.')),
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to generate AI report. Status: ${response.statusCode}')),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error communicating with AI backend: $e')),
          );
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tooth image uploaded successfully.')),
        );
      }
      
      _fetchDentalImages();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: ${e.toString().replaceAll('Exception: ', '')}')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      appBar: AppBar(
        title: const Text('Appointment Details', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientInfoCard(),
            const SizedBox(height: 20),
            _buildAppointmentDetailsCard(),
            const SizedBox(height: 20),
            _buildAiToothAnalysisCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Patient Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1C274C))),
          const SizedBox(height: 16),
          _buildInfoRow('Name', widget.appointment.patient?.fullName ?? 'N/A'),
          const Divider(),
          _buildInfoRow('Email', widget.appointment.patient?.email ?? 'N/A'),
          const Divider(),
          _buildInfoRow('Phone', widget.appointment.patient?.phone ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Appointment Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1C274C))),
          const SizedBox(height: 16),
          _buildInfoRow('Status', widget.appointment.status.name.toUpperCase()),
          const Divider(),
          _buildInfoRow('Date', DateFormat('EEEE, MMM d, yyyy').format(widget.appointment.date)),
          const Divider(),
          _buildInfoRow('Time', '${widget.appointment.startTime} - ${widget.appointment.endTime}'),
          const Divider(),
          _buildInfoRow('Hospital', widget.appointment.hospital?.name ?? 'N/A'),
          const Divider(),
          _buildInfoRow('Reason', widget.appointment.reason),
        ],
      ),
    );
  }

  Widget _buildAiToothAnalysisCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('AI Tooth Analysis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1C274C))),
          const SizedBox(height: 8),
          const Text('Upload tooth scans for future AI analysis.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          
          if (widget.appointment.status == AppointmentStatus.accepted)
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton.icon(
                onPressed: _isUploading ? null : _uploadImage,
                icon: _isUploading 
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Icon(Icons.upload_file),
                label: Text(_isUploading ? 'Uploading...' : 'Upload Tooth Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4F7DF3),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          
          const SizedBox(height: 24),
          const Text('Existing Dental Images', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          
          if (_isLoadingImages)
            const Center(child: CircularProgressIndicator())
          else if (_errorMessage != null)
            Text(_errorMessage!, style: const TextStyle(color: Colors.red))
          else if (_dentalImages.isEmpty)
            const Text('No images uploaded yet.', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic))
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _dentalImages.length,
              itemBuilder: (context, index) {
                final image = _dentalImages[index];
                return Card(
                  elevation: 0,
                  color: const Color(0xffF6F8FC),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.image, color: Color(0xff4F7DF3)),
                    title: Text(image.fileName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: Text(DateFormat('MMM d, yyyy • HH:mm').format(image.uploadedAt), style: const TextStyle(fontSize: 12)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.picture_as_pdf, color: Colors.redAccent),
                          tooltip: 'Download AI Report',
                          onPressed: () => _downloadReportForExistingImage(image.fileName),
                        ),
                        const Icon(Icons.download, size: 20, color: Colors.grey),
                      ],
                    ),
                    onTap: () => _downloadAndPreviewImage(image.id!, image.fileName),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Future<void> _downloadReportForExistingImage(String fileName) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8000/report/$fileName'));
      
      if (response.statusCode == 200) {
        final pdfBytes = response.bodyBytes;
        
        await FileSaver.instance.saveFile(
          name: 'analysis_report_${fileName.split('.').first}',
          bytes: pdfBytes,
          ext: 'pdf',
          mimeType: MimeType.pdf,
        );
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('AI Analysis Report downloaded.')),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to get report. Status: ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error communicating with AI backend: $e')),
        );
      }
    }
  }

  Future<void> _downloadAndPreviewImage(int imageId, String fileName) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final bytes = await client.dentalImage.downloadDentalImage(imageId);
      if (!mounted) return;
      Navigator.pop(context); // Close loading

      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Preview: $fileName', style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              Image.memory(
                bytes.buffer.asUint8List(),
                fit: BoxFit.contain,
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context); // Close loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download image: ${e.toString().replaceAll('Exception: ', '')}')),
      );
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: const TextStyle(color: Color(0xff1C274C), fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
