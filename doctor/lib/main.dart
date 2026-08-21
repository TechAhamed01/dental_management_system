import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/login_controller.dart';
import 'screens/landing_page.dart';
import 'features/appointments/providers/dentist_appointments_provider.dart';
import 'services/serverpod_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServerpod();
  runApp(const DentalCareApp());
}

class DentalCareApp extends StatelessWidget {
  const DentalCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => DentistAppointmentsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DentalCare',
        home: const LandingPage(),
      ),
    );
  }
}