import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/dashboard_provider.dart';
import 'screens/login_screen.dart';
import 'services/serverpod_client.dart';
import 'utils/theme.dart';
import 'widgets/layout_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeServerpod();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: const AdminDashboardApp(),
    ),
  );
}

class AdminDashboardApp extends StatelessWidget {
  const AdminDashboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dental Admin Dashboard',
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
