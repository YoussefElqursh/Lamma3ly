import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lamma3ly/routing/route_names.dart';
import 'package:lamma3ly/features/admin/dashboard/presentation/views/admin_dashboard_screen.dart';

/// All routes belonging to the Admin domain (web dashboard).
class AdminRoutes {
  AdminRoutes._();

  static final List<RouteBase> routes = [
    ShellRoute(
      builder: (context, state, child) => _AdminShell(child: child),
      routes: [
        GoRoute(
          path: '/admin',
          name: RouteNames.adminDashboard,
          builder: (context, state) => const AdminDashboardScreen(),
        ),
        GoRoute(
          path: '/admin/users',
          name: RouteNames.adminUsers,
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('User Management')),
          ),
        ),
        GoRoute(
          path: '/admin/reports',
          name: RouteNames.adminReports,
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Reports')),
          ),
        ),
        GoRoute(
          path: '/admin/settings',
          name: RouteNames.adminSettings,
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Admin Settings')),
          ),
        ),
      ],
    ),
  ];
}

/// Side navigation shell for the admin domain (web layout).
class _AdminShell extends StatelessWidget {
  final Widget child;
  const _AdminShell({required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;

    return Scaffold(
      body: Row(
        children: [
          // ─── Side Navigation Rail ──────────────────
          NavigationRail(
            selectedIndex: _calculateIndex(location),
            onDestinationSelected: (index) => _onTap(context, index),
            extended: MediaQuery.sizeOf(context).width > 1200,
            labelType: MediaQuery.sizeOf(context).width > 1200
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Icon(
                Icons.admin_panel_settings,
                size: 36,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people_outline),
                selectedIcon: Icon(Icons.people),
                label: Text('Users'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.analytics_outlined),
                selectedIcon: Icon(Icons.analytics),
                label: Text('Reports'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),

          // ─── Content ───────────────────────────────
          Expanded(child: child),
        ],
      ),
    );
  }

  int _calculateIndex(String location) {
    if (location.startsWith('/admin/users')) return 1;
    if (location.startsWith('/admin/reports')) return 2;
    if (location.startsWith('/admin/settings')) return 3;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(RouteNames.adminDashboard);
      case 1:
        context.goNamed(RouteNames.adminUsers);
      case 2:
        context.goNamed(RouteNames.adminReports);
      case 3:
        context.goNamed(RouteNames.adminSettings);
    }
  }
}
