import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dashboard_provider.dart';
import '../utils/theme.dart';
import '../utils/dentist_details_dialog.dart';
import 'package:dental_client/dental_client.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().fetchDashboardData();
    });
  }

  void _showPatientsDialog(BuildContext context) async {
    final provider = context.read<DashboardProvider>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );
    try {
      final patients = await provider.fetchAllPatients();
      Navigator.pop(context); // Close loading
      _showDataTableDialog<Patient>(
        context,
        title: 'All Patients',
        items: patients,
        columns: const ['Name', 'Email', 'Phone'],
        rowBuilder: (p) => [p.fullName, p.email, p.phone],
      );
    } catch (e) {
      Navigator.pop(context);
    }
  }

  void _showDentistsDialog(
    BuildContext context,
    String title,
    Future<List<Dentist>> Function() fetcher,
  ) async {
    final provider = context.read<DashboardProvider>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator()),
    );
    try {
      final dentists = await fetcher();
      Navigator.pop(context); // Close loading
      _showDataTableDialog<Dentist>(
        context,
        title: title,
        items: dentists,
        columns: const [
          'Name',
          'Email',
          'Phone',
          'Specialization',
          'Clinic',
          'Status',
        ],
        rowBuilder: (d) => [
          d.fullName,
          d.email,
          d.phone,
          d.specialization,
          d.clinicName,
          d.status.name.toUpperCase(),
        ],
        onViewDetails: (dentist) {
          showDentistDetailsDialog(
            context,
            dentist,
            provider,
            readOnly: dentist.status != DentistStatus.pending,
          );
        },
      );
    } catch (e) {
      Navigator.pop(context);
    }
  }

  void _showDataTableDialog<T>(
    BuildContext context, {
    required String title,
    required List<T> items,
    required List<String> columns,
    required List<String> Function(T) rowBuilder,
    void Function(T item)? onViewDetails,
  }) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            width: 850,
            constraints: const BoxConstraints(maxHeight: 600),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24)),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: items.isEmpty
                      ? const Center(child: Text('No data available.'))
                      : SingleChildScrollView(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingRowColor: MaterialStateProperty.all(AppTheme.backgroundColor),
                              columns: [
                                ...columns.map((c) => DataColumn(
                                      label: Text(c, style: const TextStyle(fontWeight: FontWeight.bold)),
                                    )),
                                if (onViewDetails != null)
                                  const DataColumn(
                                    label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                              ],
                              rows: items.map((item) {
                                final rowData = rowBuilder(item);
                                return DataRow(
                                  cells: [
                                    ...rowData.map((data) => DataCell(Text(data))),
                                    if (onViewDetails != null)
                                      DataCell(
                                        TextButton.icon(
                                          icon: const Icon(Icons.visibility_outlined, size: 16),
                                          label: const Text('View Details'),
                                          onPressed: () => onViewDetails(item),
                                        ),
                                      ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();
    final stats = provider.stats;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dashboard Overview',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => provider.fetchDashboardData(),
                tooltip: 'Refresh Data',
              )
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              _StatCard(
                title: 'Total Patients',
                value: provider.isLoading ? '...' : '${stats?.totalPatients ?? 0}',
                icon: Icons.people_outline,
                color: const Color(0xFF8B5CF6),
                onTap: () => _showPatientsDialog(context),
              ),
              _StatCard(
                title: 'Total Doctors',
                value: provider.isLoading ? '...' : '${stats?.totalDoctors ?? 0}',
                icon: Icons.medical_services_outlined,
                color: const Color(0xFF0EA5E9),
                onTap: () => _showDentistsDialog(context, 'All Doctors', provider.fetchAllDentists),
              ),
              _StatCard(
                title: 'Pending Apps',
                value: provider.isLoading ? '...' : '${stats?.pendingDoctors ?? 0}',
                icon: Icons.hourglass_empty,
                color: const Color(0xFFF59E0B),
                onTap: () {}, // Handled on the Pending Dentists screen usually
              ),
              _StatCard(
                title: 'Approved',
                value: provider.isLoading ? '...' : '${stats?.approvedDoctors ?? 0}',
                icon: Icons.check_circle_outline,
                color: const Color(0xFF10B981),
                onTap: () => _showDentistsDialog(context, 'Approved Doctors', provider.fetchApprovedDentists),
              ),
              _StatCard(
                title: 'Rejected',
                value: provider.isLoading ? '...' : '${stats?.rejectedDoctors ?? 0}',
                icon: Icons.cancel_outlined,
                color: const Color(0xFFEF4444),
                onTap: () => _showDentistsDialog(context, 'Rejected Doctors', provider.fetchRejectedDentists),
              ),
            ],
          ),
          const SizedBox(height: 48),
          Text(
            'Recent Registrations (Pending)',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 16),
          if (provider.isLoading)
            const CircularProgressIndicator()
          else if (provider.pendingDentists.isEmpty)
            const Text('No recent registrations.')
          else
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.pendingDentists.take(3).length, // Show up to 3
                separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFE2E8F0)),
                itemBuilder: (context, index) {
                  final d = provider.pendingDentists[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                      child: const Icon(Icons.person, color: AppTheme.primaryColor),
                    ),
                    title: Text('Dr. ${d.fullName}', style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('${d.specialization} | ${d.clinicName}'),
                    trailing: const Chip(
                      label: Text('Pending', style: TextStyle(color: Color(0xFFF59E0B), fontSize: 12)),
                      backgroundColor: Color(0xFFFEF3C7),
                      side: BorderSide.none,
                    ),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 220,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 24),
                  ),
                  const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
