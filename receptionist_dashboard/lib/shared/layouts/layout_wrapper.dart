import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/authentication/providers/auth_provider.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/dentists/screens/dentists_screen.dart';
import '../../features/appointments/screens/appointments_screen.dart';
import '../../features/patients/screens/patients_screen.dart';
import '../../features/hospital/screens/hospital_profile_screen.dart';

class LayoutWrapper extends StatefulWidget {
  const LayoutWrapper({super.key});

  @override
  State<LayoutWrapper> createState() => _LayoutWrapperState();
}

class _LayoutWrapperState extends State<LayoutWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const DentistsScreen(),
    const AppointmentsScreen(),
    const PatientsScreen(),
    const HospitalProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 768;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: isDesktop ? null : AppBar(
        title: const Text('Hospital Reception'),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: isDesktop ? null : _buildSidebar(context),
      body: Row(
        children: [
          if (isDesktop) _buildSidebar(context),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final isDesktop = MediaQuery.of(context).size.width >= 768;
    
    return Container(
      width: 250,
      color: const Color(0xFF0F172A),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                const Icon(Icons.local_hospital, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Reception Portal',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 16),
          _SidebarItem(
            icon: Icons.dashboard_outlined,
            label: 'Dashboard',
            isSelected: _selectedIndex == 0,
            onTap: () => _onMenuTap(0, isDesktop),
          ),
          _SidebarItem(
            icon: Icons.medical_services_outlined,
            label: 'Dentists',
            isSelected: _selectedIndex == 1,
            onTap: () => _onMenuTap(1, isDesktop),
          ),
          _SidebarItem(
            icon: Icons.event_note_outlined,
            label: 'Appointments',
            isSelected: _selectedIndex == 2,
            onTap: () => _onMenuTap(2, isDesktop),
          ),
          _SidebarItem(
            icon: Icons.people_outline,
            label: 'Patients',
            isSelected: _selectedIndex == 3,
            onTap: () => _onMenuTap(3, isDesktop),
          ),
          _SidebarItem(
            icon: Icons.business_outlined,
            label: 'Hospital Profile',
            isSelected: _selectedIndex == 4,
            onTap: () => _onMenuTap(4, isDesktop),
          ),
          const Spacer(),
          const Divider(color: Colors.white24, height: 1),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            leading: const Icon(Icons.logout, color: Colors.white54),
            title: const Text('Logout', style: TextStyle(color: Colors.white70)),
            onTap: () => auth.logout(),
          ),
        ],
      ),
    );
  }

  void _onMenuTap(int index, bool isDesktop) {
    setState(() {
      _selectedIndex = index;
    });
    if (!isDesktop) {
      Navigator.of(context).pop(); // Close drawer
    }
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? Colors.white : Colors.white54;
    final bgColor = isSelected ? const Color(0xFF0F766E) : Colors.transparent;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
