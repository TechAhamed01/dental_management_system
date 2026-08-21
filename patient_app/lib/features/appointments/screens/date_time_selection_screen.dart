import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/appointment_booking_provider.dart';
import 'appointment_reason_screen.dart';

class DateTimeSelectionScreen extends StatefulWidget {
  const DateTimeSelectionScreen({super.key});

  @override
  State<DateTimeSelectionScreen> createState() => _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  DateTime _selectedDate = DateTime.now();
  String? _selectedSlot;

  // Predefined slots for Phase 6 MVP
  final List<Map<String, String>> _slots = [
    {'start': '09:00', 'end': '10:00', 'label': '09:00 AM - 10:00 AM'},
    {'start': '10:00', 'end': '11:00', 'label': '10:00 AM - 11:00 AM'},
    {'start': '11:00', 'end': '12:00', 'label': '11:00 AM - 12:00 PM'},
    {'start': '14:00', 'end': '15:00', 'label': '02:00 PM - 03:00 PM'},
    {'start': '15:00', 'end': '16:00', 'label': '03:00 PM - 04:00 PM'},
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _selectedSlot = null; // Reset slot when date changes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppointmentBookingProvider>();
    final hospital = provider.selectedHospital;

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),
      appBar: AppBar(
        title: const Text('Select Date & Time', style: TextStyle(color: Color(0xff1C274C), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xff1C274C)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hospital Info
            if (hospital != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_hospital, color: Color(0xff2455F4)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        hospital.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),

            // Date Picker
            const Text('Select Date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1C274C))),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => _selectDate(context),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('EEEE, MMM d, yyyy').format(_selectedDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_month, color: Color(0xff2455F4)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Time Slots
            const Text('Select Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff1C274C))),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _slots.map((slot) {
                final isSelected = _selectedSlot == slot['start'];
                return ChoiceChip(
                  label: Text(slot['label']!),
                  selected: isSelected,
                  selectedColor: const Color(0xff2455F4),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xff1C274C),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  onSelected: (selected) {
                    setState(() {
                      _selectedSlot = selected ? slot['start'] : null;
                    });
                  },
                );
              }).toList(),
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
                onPressed: _selectedSlot == null
                    ? null
                    : () {
                        provider.selectDate(_selectedDate);
                        final slot = _slots.firstWhere((s) => s['start'] == _selectedSlot);
                        provider.selectTimeSlot(slot['start']!, slot['end']!);
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AppointmentReasonScreen(),
                          ),
                        );
                      },
                child: const Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
