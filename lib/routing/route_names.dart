/// Centralized route name constants.
///
/// Using named routes ensures type-safety and prevents
/// typos in navigation calls across the app.
class RouteNames {
  RouteNames._();

  // ─── Auth ──────────────────────────────────────────────
  static const String login = 'login';
  static const String register = 'register';
  static const String splash = 'splash';

  // ─── Customer ──────────────────────────────────────────
  static const String customerHome = 'customer-home';
  static const String customerBookings = 'customer-bookings';
  static const String customerBookingDetails = 'customer-booking-details';
  static const String customerProfile = 'customer-profile';
  static const String customerNewBooking = 'customer-new-booking';

  // ─── Servicer ──────────────────────────────────────────
  static const String servicerHome = 'servicer-home';
  static const String servicerJobs = 'servicer-jobs';
  static const String servicerJobDetails = 'servicer-job-details';
  static const String servicerProfile = 'servicer-profile';

  // ─── Admin ─────────────────────────────────────────────
  static const String adminDashboard = 'admin-dashboard';
  static const String adminUsers = 'admin-users';
  static const String adminReports = 'admin-reports';
  static const String adminSettings = 'admin-settings';
}
