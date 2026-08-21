import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'screens/landing_page.dart';
import 'services/serverpod_client.dart';
import 'features/appointments/providers/appointment_booking_provider.dart';
import 'features/appointments/providers/patient_appointments_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServerpod();
  runApp(const PatientApp());
}

class PatientApp extends StatelessWidget {
  const PatientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => AppointmentBookingProvider()),
        ChangeNotifierProvider(create: (_) => PatientAppointmentsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Patient App',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const LandingPage(),
      ),
    );
  }
}