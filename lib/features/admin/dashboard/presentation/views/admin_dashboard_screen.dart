import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamma3ly/core/utils/extensions.dart';
import 'package:lamma3ly/shared/auth/presentation/viewmodels/auth_cubit.dart';

/// Admin dashboard screen — web-optimized layout with stats overview.
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthCubit>().logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overview', style: context.textTheme.displaySmall),
            const SizedBox(height: 24),

            // ─── Stats Grid ──────────────────────────
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 900 ? 4 : 2;
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.8,
                  children: [
                    _DashboardCard(
                      title: 'Total Users',
                      value: '0',
                      icon: Icons.people,
                      color: context.colorScheme.primary,
                    ),
                    _DashboardCard(
                      title: 'Active Bookings',
                      value: '0',
                      icon: Icons.calendar_today,
                      color: Colors.orange,
                    ),
                    _DashboardCard(
                      title: 'Servicers',
                      value: '0',
                      icon: Icons.build,
                      color: Colors.green,
                    ),
                    _DashboardCard(
                      title: 'Revenue',
                      value: '\$0',
                      icon: Icons.attach_money,
                      color: Colors.purple,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),

            Text('Recent Activity', style: context.textTheme.headlineSmall),
            const SizedBox(height: 12),
            Card(
              child: SizedBox(
                width: double.infinity,
                height: 200,
                child: Center(
                  child: Text(
                    'Activity feed will appear here',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withAlpha(153),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: color, size: 28),
                Text(value, style: context.textTheme.headlineMedium),
              ],
            ),
            Text(title, style: context.textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
