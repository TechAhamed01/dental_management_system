import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/appointment_booking_provider.dart';
import 'appointment_success_screen.dart';

class AppointmentConfirmationScreen extends StatelessWidget {
  const AppointmentConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppointmentBookingProvider>();
    final hospital = provider.selectedHospital;
    final date = provider.selectedDate;
    final startTime = provider.selectedStartTime;
    final endTime = provider.selectedEndTime;
    final reason = provider.reason;

    if (hospital == null || date == null || startTime == null) {
      return const Scaffold(body: Center(child: Text('Missing booking information')));
    }

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),
      appBar: AppBar(
        title: const Text('Confirm Appointment', style: TextStyle(color: Color(0xff1C274C), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff1C274C)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Review Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff1C274C)),
            ),
            const SizedBox(height: 20),
            
            // Details Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
                ],
              ),
              child: Column(
                children: [
                  _detailRow(Icons.local_hospital, 'Hospital', hospital.name),
                  const Divider(height: 30),
                  _detailRow(Icons.calendar_today, 'Date', DateFormat('EEEE, MMM d, yyyy').format(date)),
                  const Divider(height: 30),
                  _detailRow(Icons.access_time, 'Time', '$startTime - $endTime'),
                  const Divider(height: 30),
                  _detailRow(Icons.description, 'Reason', reason!),
                ],
              ),
            ),
            
            const SizedBox(height: 40),

            if (provider.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(provider.errorMessage!, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff2455F4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: provider.isLoading
                    ? null
                    : () async {
                        final success = await provider.submitAppointmentRequest();
                        if (success && context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AppointmentSuccessScreen(
                                hospitalName: hospital.name,
                                date: date,
                                startTime: startTime,
                              ),
                            ),
                            (route) => route.isFirst,
                          );
                        }
                      },
                child: provider.isLoading
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white))
                    : const Text('Request Appointment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xff2455F4), size: 22),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(color: Color(0xff1C274C), fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}
