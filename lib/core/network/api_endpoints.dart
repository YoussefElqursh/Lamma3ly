/// Centralized API endpoint definitions.
///
/// All endpoint paths are defined here to avoid scattered string literals.
class ApiEndpoints {
  ApiEndpoints._();

  // ─── Auth ──────────────────────────────────────────────
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';
  static const String profile = '/auth/profile';

  // ─── Customer ──────────────────────────────────────────
  static const String services = '/services';
  static const String bookings = '/bookings';
  static const String bookingDetails = '/bookings/{id}';

  // ─── Servicer ──────────────────────────────────────────
  static const String jobs = '/servicer/jobs';
  static const String jobDetails = '/servicer/jobs/{id}';
  static const String jobAccept = '/servicer/jobs/{id}/accept';
  static const String jobReject = '/servicer/jobs/{id}/reject';

  // ─── Admin ─────────────────────────────────────────────
  static const String adminUsers = '/admin/users';
  static const String adminDashboard = '/admin/dashboard';
  static const String adminReports = '/admin/reports';
}
