import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dental_client/dental_client.dart';

class DentistAppointmentDetailsScreen extends StatelessWidget {
  final Appointment appointment;

  const DentistAppointmentDetailsScreen({super.key, required this.appointment});

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
            Container(
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
                  _buildInfoRow('Name', appointment.patient?.fullName ?? 'N/A'),
                  const Divider(),
                  _buildInfoRow('Email', appointment.patient?.email ?? 'N/A'),
                  const Divider(),
                  _buildInfoRow('Phone', appointment.patient?.phone ?? 'N/A'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
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
                  _buildInfoRow('Status', appointment.status.name.toUpperCase()),
                  const Divider(),
                  _buildInfoRow('Date', DateFormat('EEEE, MMM d, yyyy').format(appointment.date)),
                  const Divider(),
                  _buildInfoRow('Time', '${appointment.startTime} - ${appointment.endTime}'),
                  const Divider(),
                  _buildInfoRow('Hospital', appointment.hospital?.name ?? 'N/A'),
                  const Divider(),
                  _buildInfoRow('Reason', appointment.reason),
                ],
              ),
            ),
          ],
        ),
      ),
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
