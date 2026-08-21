import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appointment_booking_provider.dart';
import 'appointment_confirmation_screen.dart';

class AppointmentReasonScreen extends StatefulWidget {
  const AppointmentReasonScreen({super.key});

  @override
  State<AppointmentReasonScreen> createState() => _AppointmentReasonScreenState();
}

class _AppointmentReasonScreenState extends State<AppointmentReasonScreen> {
  final _reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),
      appBar: AppBar(
        title: const Text('Reason for Visit', style: TextStyle(color: Color(0xff1C274C), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff1C274C)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please describe the reason for your appointment:',
                style: TextStyle(fontSize: 16, color: Color(0xff1C274C)),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _reasonController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'e.g., Routine checkup, tooth pain, cleaning...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xff2455F4), width: 1.5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a reason.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2455F4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AppointmentBookingProvider>().setReason(_reasonController.text.trim());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AppointmentConfirmationScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text('Review Appointment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
