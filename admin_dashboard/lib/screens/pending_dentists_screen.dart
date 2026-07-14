import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dashboard_provider.dart';
import '../utils/theme.dart';
import 'package:dental_client/dental_client.dart';

class PendingDentistsScreen extends StatefulWidget {
  const PendingDentistsScreen({Key? key}) : super(key: key);

  @override
  _PendingDentistsScreenState createState() => _PendingDentistsScreenState();
}

class _PendingDentistsScreenState extends State<PendingDentistsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().fetchDashboardData();
    });
  }

  void _showConfirmation(String action, Dentist dentist, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('$action Dentist'),
        content: Text('Are you sure you want to $action Dr. ${dentist.fullName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: action == 'Approve' ? AppTheme.successColor : AppTheme.errorColor,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm();
            },
            child: Text(action),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Review Applications',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 22),
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () => provider.fetchDashboardData(),
                tooltip: 'Refresh',
              )
            ],
          ),
          const SizedBox(height: 24),
          if (provider.errorMessage != null)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                provider.errorMessage!,
                style: const TextStyle(color: AppTheme.errorColor),
              ),
            ),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.pendingDentists.isEmpty
                    ? const Center(child: Text('No pending applications.'))
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: ListView.separated(
                          itemCount: provider.pendingDentists.length,
                          separatorBuilder: (_, __) => const Divider(height: 1, color: Color(0xFFE2E8F0)),
                          itemBuilder: (context, index) {
                            final dentist = provider.pendingDentists[index];
                            return Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                                    child: const Icon(Icons.person, size: 28, color: AppTheme.primaryColor),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dr. ${dentist.fullName}',
                                          style: Theme.of(context).textTheme.titleLarge,
                                        ),
                                        const SizedBox(height: 4),
                                        Text('${dentist.specialization}', style: Theme.of(context).textTheme.bodyMedium),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.email, size: 16, color: AppTheme.textSecondary),
                                            const SizedBox(width: 8),
                                            Text(dentist.email, style: Theme.of(context).textTheme.bodyMedium),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(Icons.phone, size: 16, color: AppTheme.textSecondary),
                                            const SizedBox(width: 8),
                                            Text(dentist.phone, style: Theme.of(context).textTheme.bodyMedium),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'License: ${dentist.licenseNumber}',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Exp: ${dentist.experience} years',
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppTheme.successColor,
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        ),
                                        icon: const Icon(Icons.check, size: 18),
                                        label: const Text('Approve'),
                                        onPressed: () {
                                          _showConfirmation('Approve', dentist, () {
                                            provider.approveDentist(dentist.id!);
                                          });
                                        },
                                      ),
                                      const SizedBox(width: 12),
                                      OutlinedButton.icon(
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: AppTheme.errorColor,
                                          side: const BorderSide(color: AppTheme.errorColor),
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                        ),
                                        icon: const Icon(Icons.close, size: 18),
                                        label: const Text('Reject'),
                                        onPressed: () {
                                          _showConfirmation('Reject', dentist, () {
                                            provider.rejectDentist(dentist.id!);
                                          });
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
