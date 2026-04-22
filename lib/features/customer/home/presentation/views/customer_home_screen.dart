import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lamma3ly/core/utils/extensions.dart';
import 'package:lamma3ly/shared/auth/presentation/viewmodels/auth_cubit.dart';

/// Customer domain home screen.
class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lamma3ly'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
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
            // ─── Greeting ────────────────────────────
            Text(
              'Hello! 👋',
              style: context.textTheme.displaySmall,
            ),
            const SizedBox(height: 4),
            Text(
              'What service do you need today?',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurface.withAlpha(153),
              ),
            ),
            const SizedBox(height: 24),

            // ─── Search Bar ──────────────────────────
            TextField(
              decoration: InputDecoration(
                hintText: 'Search services...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ─── Categories ──────────────────────────
            Text('Categories', style: context.textTheme.headlineSmall),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: const [
                  _CategoryCard(icon: Icons.plumbing, label: 'Plumbing'),
                  _CategoryCard(icon: Icons.electrical_services, label: 'Electrical'),
                  _CategoryCard(icon: Icons.cleaning_services, label: 'Cleaning'),
                  _CategoryCard(icon: Icons.format_paint, label: 'Painting'),
                  _CategoryCard(icon: Icons.carpenter, label: 'Carpentry'),
                  _CategoryCard(icon: Icons.ac_unit, label: 'AC Repair'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  const _CategoryCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // TODO: Navigate to service listing
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: context.colorScheme.primary),
            const SizedBox(height: 8),
            Text(label, style: context.textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
