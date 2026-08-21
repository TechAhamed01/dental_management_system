import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/patient_appointments_provider.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({super.key});

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PatientAppointmentsProvider>().fetchAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PatientAppointmentsProvider>();

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),
      appBar: AppBar(
        title: const Text('My Appointments', style: TextStyle(color: Color(0xff1C274C), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false, // since it's a tab
      ),
      body: provider.isLoading && provider.appointments.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
              ? Center(child: Text(provider.errorMessage!, style: const TextStyle(color: Colors.red)))
              : provider.appointments.isEmpty
                  ? const Center(child: Text('No appointments found.', style: TextStyle(color: Colors.grey)))
                  : RefreshIndicator(
                      onRefresh: () => provider.fetchAppointments(),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: provider.appointments.length,
                        itemBuilder: (context, index) {
                          final apt = provider.appointments[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          apt.hospital?.name ?? 'Unknown Hospital',
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff1C274C)),
                                        ),
                                      ),
                                      _statusBadge(apt.status.name),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                                      const SizedBox(width: 8),
                                      Text(DateFormat('MMM d, yyyy').format(apt.date), style: const TextStyle(color: Colors.grey)),
                                      const SizedBox(width: 16),
                                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                      const SizedBox(width: 8),
                                      Text(apt.startTime, style: const TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text('Reason: ${apt.reason}', style: const TextStyle(color: Color(0xff1C274C))),
                                  const SizedBox(height: 12),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF0F4FF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.person, color: Color(0xff4A90E2), size: 20),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            apt.dentist != null ? 'Dr. ${apt.dentist!.fullName} (${apt.dentist!.specialization})' : 'Dentist Allocation Pending',
                                            style: TextStyle(
                                              color: apt.dentist != null ? const Color(0xff1C274C) : Colors.grey,
                                              fontWeight: apt.dentist != null ? FontWeight.bold : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  if (apt.status.name == 'pending') ...[
                                    const SizedBox(height: 16),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () {
                                          provider.cancelAppointment(apt.id!);
                                        },
                                        child: const Text('Cancel Request', style: TextStyle(color: Colors.red)),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }

  Widget _statusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'pending':
        bgColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange;
        break;
      case 'accepted':
        bgColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green;
        break;
      case 'rejected':
      case 'cancelled':
        bgColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red;
        break;
      default:
        bgColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
