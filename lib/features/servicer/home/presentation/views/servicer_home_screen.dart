import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamma3ly/core/utils/extensions.dart';
import 'package:lamma3ly/shared/auth/presentation/viewmodels/auth_cubit.dart';

/// Servicer domain home screen — overview of stats and recent activity.
class ServicerHomeScreen extends StatelessWidget {
  const ServicerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthCubit>().logout(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, Provider! 🔧', style: context.textTheme.displaySmall),
            const SizedBox(height: 24),

            // ─── Stats Cards ──────────────────────────
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Pending',
                    value: '0',
                    icon: Icons.pending_actions,
                    color: context.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Active',
                    value: '0',
                    icon: Icons.play_circle_outline,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: 'Completed',
                    value: '0',
                    icon: Icons.check_circle_outline,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            Text('Recent Activity', style: context.textTheme.headlineSmall),
            const SizedBox(height: 12),
            Expanded(
              child: Center(
                child: Text(
                  'No recent activity',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurface.withAlpha(153),
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

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 8),
            Text(value, style: context.textTheme.headlineMedium),
            const SizedBox(height: 4),
            Text(title, style: context.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}
