import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../screens/dashboard_screen.dart';
import '../screens/pending_dentists_screen.dart';
import '../utils/theme.dart';

class LayoutWrapper extends StatefulWidget {
  const LayoutWrapper({Key? key}) : super(key: key);

  @override
  _LayoutWrapperState createState() => _LayoutWrapperState();
}

class _LayoutWrapperState extends State<LayoutWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const PendingDentistsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final admin = context.watch<AuthProvider>().currentAdmin;

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 260,
            color: AppTheme.sidebarColor,
            child: Column(
              children: [
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.medical_services, color: AppTheme.sidebarColor, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DentalCare',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                          ),
                          Text(
                            'Admin Portal',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.white70,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                _SidebarItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  isSelected: _selectedIndex == 0,
                  onTap: () => setState(() => _selectedIndex = 0),
                ),
                _SidebarItem(
                  icon: Icons.pending_actions,
                  title: 'Pending Dentists',
                  isSelected: _selectedIndex == 1,
                  onTap: () => setState(() => _selectedIndex = 1),
                ),
                const Spacer(),
                const Divider(color: Colors.white24, height: 1),
                // Admin Profile Section
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white24,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Super Admin',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              admin?.email ?? 'admin@dental.com',
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout, color: Colors.white70, size: 20),
                        onPressed: () {
                          context.read<AuthProvider>().logout();
                        },
                        tooltip: 'Logout',
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main Content Area with Top Bar
          Expanded(
            child: Container(
              color: AppTheme.backgroundColor,
              child: Column(
                children: [
                  // Top Bar
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.menu, color: AppTheme.textSecondary),
                        const SizedBox(width: 24),
                        Text(
                          _selectedIndex == 0 ? 'Dashboard Overview' : 'Pending Dentists',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        const Icon(Icons.search, color: AppTheme.textSecondary),
                        const SizedBox(width: 24),
                        Stack(
                          children: [
                            const Icon(Icons.notifications_none, color: AppTheme.textSecondary, size: 28),
                            Positioned(
                              right: 2,
                              top: 2,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  color: AppTheme.errorColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 32),
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: AppTheme.primaryColor,
                          child: Icon(Icons.person, color: Colors.white, size: 20),
                        ),
                      ],
                    ),
                  ),
                  // Screen Content
                  Expanded(
                    child: _screens[_selectedIndex],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.sidebarActiveColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white70,
                size: 22,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
