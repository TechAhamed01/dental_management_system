import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme.dart';
import 'features/authentication/providers/auth_provider.dart';
import 'features/dashboard/providers/dashboard_provider.dart';
import 'features/dentists/providers/dentist_list_provider.dart';
import 'features/appointments/providers/receptionist_appointments_provider.dart';
import 'features/authentication/screens/login_screen.dart';
import 'shared/layouts/layout_wrapper.dart';
import 'shared/services/serverpod_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServerpod();
  
  final authProvider = AuthProvider();
  await authProvider.checkAuthState();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => DentistListProvider()),
        ChangeNotifierProvider(create: (_) => ReceptionistAppointmentsProvider()),
      ],
      child: const ReceptionistDashboardApp(),
    ),
  );
}

class ReceptionistDashboardApp extends StatelessWidget {
  const ReceptionistDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receptionist Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if (auth.isAuthenticated) {
            return const LayoutWrapper();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
