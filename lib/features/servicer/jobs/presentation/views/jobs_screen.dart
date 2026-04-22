import 'package:flutter/material.dart';
import 'package:lamma3ly/core/utils/extensions.dart';

/// Servicer jobs listing screen.
class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jobs')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.work_outline,
              size: 64,
              color: context.colorScheme.primary.withAlpha(128),
            ),
            const SizedBox(height: 16),
            Text('No jobs yet', style: context.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'New service requests will appear here',
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.onSurface.withAlpha(153),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
