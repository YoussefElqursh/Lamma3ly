import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lamma3ly/routing/route_names.dart';
import 'package:lamma3ly/features/servicer/home/presentation/views/servicer_home_screen.dart';
import 'package:lamma3ly/features/servicer/jobs/presentation/views/jobs_screen.dart';

/// All routes belonging to the Servicer domain.
class ServicerRoutes {
  ServicerRoutes._();

  static final List<RouteBase> routes = [
    ShellRoute(
      builder: (context, state, child) => _ServicerShell(child: child),
      routes: [
        GoRoute(
          path: '/servicer',
          name: RouteNames.servicerHome,
          builder: (context, state) => const ServicerHomeScreen(),
        ),
        GoRoute(
          path: '/servicer/jobs',
          name: RouteNames.servicerJobs,
          builder: (context, state) => const JobsScreen(),
        ),
        GoRoute(
          path: '/servicer/profile',
          name: RouteNames.servicerProfile,
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Servicer Profile')),
          ),
        ),
      ],
    ),
  ];
}

/// Bottom navigation shell for the servicer domain.
class _ServicerShell extends StatelessWidget {
  final Widget child;
  const _ServicerShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateIndex(GoRouterState.of(context).matchedLocation),
        onDestinationSelected: (index) => _onTap(context, index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.work_outline),
            selectedIcon: Icon(Icons.work),
            label: 'Jobs',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _calculateIndex(String location) {
    if (location.startsWith('/servicer/jobs')) return 1;
    if (location.startsWith('/servicer/profile')) return 2;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(RouteNames.servicerHome);
      case 1:
        context.goNamed(RouteNames.servicerJobs);
      case 2:
        context.goNamed(RouteNames.servicerProfile);
    }
  }
}
