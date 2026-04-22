import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lamma3ly/routing/route_names.dart';
import 'package:lamma3ly/features/customer/home/presentation/views/customer_home_screen.dart';
import 'package:lamma3ly/features/customer/booking/presentation/views/booking_screen.dart';

/// All routes belonging to the Customer domain.
class CustomerRoutes {
  CustomerRoutes._();

  static final List<RouteBase> routes = [
    ShellRoute(
      builder: (context, state, child) => _CustomerShell(child: child),
      routes: [
        GoRoute(
          path: '/customer',
          name: RouteNames.customerHome,
          builder: (context, state) => const CustomerHomeScreen(),
        ),
        GoRoute(
          path: '/customer/bookings',
          name: RouteNames.customerBookings,
          builder: (context, state) => const BookingScreen(),
        ),
        GoRoute(
          path: '/customer/profile',
          name: RouteNames.customerProfile,
          builder: (context, state) => const Scaffold(
            body: Center(child: Text('Customer Profile')),
          ),
        ),
      ],
    ),
  ];
}

/// Bottom navigation shell for the customer domain.
class _CustomerShell extends StatelessWidget {
  final Widget child;
  const _CustomerShell({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateIndex(GoRouterState.of(context).matchedLocation),
        onDestinationSelected: (index) => _onTap(context, index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Bookings',
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
    if (location.startsWith('/customer/bookings')) return 1;
    if (location.startsWith('/customer/profile')) return 2;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(RouteNames.customerHome);
      case 1:
        context.goNamed(RouteNames.customerBookings);
      case 2:
        context.goNamed(RouteNames.customerProfile);
    }
  }
}
