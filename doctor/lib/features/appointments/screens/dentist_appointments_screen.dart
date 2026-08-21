import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:dental_client/dental_client.dart';
import '../providers/dentist_appointments_provider.dart';
import 'appointment_details_screen.dart';

class DentistAppointmentsScreen extends StatefulWidget {
  const DentistAppointmentsScreen({super.key});

  @override
  State<DentistAppointmentsScreen> createState() => _DentistAppointmentsScreenState();
}

class _DentistAppointmentsScreenState extends State<DentistAppointmentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DentistAppointmentsProvider>().fetchAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      appBar: AppBar(
        title: const Text('My Appointments', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<DentistAppointmentsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.errorMessage!, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.fetchAppointments(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.appointments.isEmpty) {
            return const Center(
              child: Text('No appointments assigned to you yet.', style: TextStyle(color: Colors.grey, fontSize: 16)),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.fetchAppointments(),
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                if (provider.todaysAppointments.isNotEmpty) ...[
                  const Text('Today', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  ...provider.todaysAppointments.map((apt) => _buildAppointmentCard(context, apt)),
                  const SizedBox(height: 20),
                ],
                if (provider.upcomingAppointments.isNotEmpty) ...[
                  const Text('Upcoming', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  ...provider.upcomingAppointments.map((apt) => _buildAppointmentCard(context, apt)),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppointmentCard(BuildContext context, Appointment apt) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DentistAppointmentDetailsScreen(appointment: apt),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xffEAF2FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(DateFormat('MMM').format(apt.date), style: const TextStyle(color: Color(0xff4F7DF3), fontWeight: FontWeight.bold, fontSize: 12)),
                    Text(DateFormat('dd').format(apt.date), style: const TextStyle(color: Color(0xff4F7DF3), fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(apt.patient?.fullName ?? 'Unknown Patient', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text('${apt.startTime} - ${apt.endTime}', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(apt.status.name.toUpperCase(), style: TextStyle(color: apt.status == AppointmentStatus.accepted ? Colors.green : Colors.orange, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
