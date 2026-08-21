import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dental_client/dental_client.dart';
import '../../../../shared/services/serverpod_client.dart';
import '../../../../core/theme.dart';

import 'package:provider/provider.dart';
import '../providers/receptionist_appointments_provider.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final int appointmentId;

  const AppointmentDetailsScreen({super.key, required this.appointmentId});

  @override
  State<AppointmentDetailsScreen> createState() => _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  Appointment? _appointment;
  bool _isLoading = true;
  String? _errorMessage;
  
  List<Dentist> _availableDentists = [];
  Dentist? _selectedDentist;
  bool _isAllocating = false;

  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  Future<void> _fetchDetails() async {
    try {
      final apt = await client.appointment.getHospitalAppointmentDetails(widget.appointmentId);
      List<Dentist> dentists = [];
      if (apt != null && apt.status == AppointmentStatus.pending) {
         dentists = await context.read<ReceptionistAppointmentsProvider>().fetchAvailableDentists();
      }
      if (mounted) {
        setState(() {
          _appointment = apt;
          _availableDentists = dentists;
          if (dentists.isNotEmpty) {
            _selectedDentist = dentists.first;
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceAll('Exception: ', '');
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _allocateDentist() async {
    if (_selectedDentist == null || _appointment == null) return;
    
    setState(() {
      _isAllocating = true;
    });

    try {
      await context.read<ReceptionistAppointmentsProvider>().allocateDentist(_appointment!.id!, _selectedDentist!.id!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dentist allocated successfully!')));
        _fetchDetails(); // Refresh to get the updated status and assigned dentist
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to allocate: ${e.toString().replaceAll('Exception: ', '')}')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isAllocating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Appointment Details'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xff1C274C),
        elevation: 1,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)))
              : _appointment == null
                  ? const Center(child: Text('Appointment not found'))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionHeader('Patient Information'),
                          const SizedBox(height: 16),
                          _buildInfoCard([
                            _buildInfoRow('Name', _appointment!.patient?.fullName ?? 'N/A'),
                            const Divider(),
                            _buildInfoRow('Email', _appointment!.patient?.email ?? 'N/A'),
                            const Divider(),
                            _buildInfoRow('Phone', _appointment!.patient?.phone ?? 'N/A'),
                          ]),
                          
                          const SizedBox(height: 32),
                          
                          _buildSectionHeader('Appointment Information'),
                          const SizedBox(height: 16),
                          _buildInfoCard([
                            _buildInfoRow('Status', _appointment!.status.name.toUpperCase()),
                            const Divider(),
                            _buildInfoRow('Date', DateFormat('EEEE, MMM d, yyyy').format(_appointment!.date)),
                            const Divider(),
                            _buildInfoRow('Time', '${_appointment!.startTime} - ${_appointment!.endTime}'),
                            const Divider(),
                            _buildInfoRow('Reason', _appointment!.reason),
                            const Divider(),
                            _buildInfoRow('Requested At', DateFormat('MMM d, yyyy HH:mm').format(_appointment!.createdAt)),
                          ]),

                          const SizedBox(height: 32),
                          
                          if (_appointment!.status == AppointmentStatus.accepted && _appointment!.dentist != null) ...[
                            _buildSectionHeader('Allocated Dentist'),
                            const SizedBox(height: 16),
                            _buildInfoCard([
                              _buildInfoRow('Name', 'Dr. ${_appointment!.dentist!.fullName}'),
                              const Divider(),
                              _buildInfoRow('Specialization', _appointment!.dentist!.specialization),
                            ]),
                          ] else if (_appointment!.status == AppointmentStatus.pending) ...[
                             _buildSectionHeader('Dentist Allocation'),
                            const SizedBox(height: 16),
                            _buildInfoCard([
                              if (_availableDentists.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text('No approved dentists available in this hospital.', style: TextStyle(color: Colors.red)),
                                )
                              else ...[
                                const Text('Select an approved dentist for this appointment:', style: TextStyle(color: Colors.grey)),
                                const SizedBox(height: 16),
                                DropdownButtonFormField<Dentist>(
                                  value: _selectedDentist,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  ),
                                  items: _availableDentists.map((d) {
                                    return DropdownMenuItem(
                                      value: d,
                                      child: Text('Dr. ${d.fullName} - ${d.specialization}'),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedDentist = val;
                                    });
                                  },
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: _isAllocating || _selectedDentist == null ? null : _allocateDentist,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.primaryColor,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    ),
                                    child: _isAllocating 
                                        ? const CircularProgressIndicator(color: Colors.white)
                                        : const Text('Allocate Dentist', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ]
                            ]),
                          ],
                        ],
                      ),
                    ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1C274C)),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
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
