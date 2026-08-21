import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dental_client/dental_client.dart';
import '../../../core/theme.dart';
import '../providers/dentist_list_provider.dart';
import 'registration/dentist_registration_screen.dart';

class DentistsScreen extends StatefulWidget {
  const DentistsScreen({super.key});

  @override
  State<DentistsScreen> createState() => _DentistsScreenState();
}

class _DentistsScreenState extends State<DentistsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DentistListProvider>().fetchDentists();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DentistListProvider>();

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Hospital Dentists'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppTheme.primaryColor),
            onPressed: provider.fetchDentists,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const DentistRegistrationScreen(),
            ),
          ).then((_) {
            provider.fetchDentists(); // Refresh after registration
          });
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Dentist', style: TextStyle(color: Colors.white)),
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(DentistListProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppTheme.errorColor),
            const SizedBox(height: 16),
            Text(
              provider.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppTheme.errorColor),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: provider.fetchDentists,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (provider.dentists.isEmpty) {
      return const Center(
        child: Text(
          'No dentists found for this hospital.\nClick "Add Dentist" to register one.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: provider.dentists.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final dentist = provider.dentists[index];
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
              child: const Icon(Icons.person, color: AppTheme.primaryColor),
            ),
            title: Text(
              'Dr. ${dentist.fullName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(dentist.specialization),
            trailing: _buildStatusChip(dentist.status),
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(DentistStatus status) {
    Color color;
    switch (status) {
      case DentistStatus.pending:
        color = Colors.orange;
        break;
      case DentistStatus.approved:
        color = AppTheme.successColor;
        break;
      case DentistStatus.rejected:
      case DentistStatus.terminated:
        color = AppTheme.errorColor;
        break;
      case DentistStatus.suspended:
        color = Colors.redAccent;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}

