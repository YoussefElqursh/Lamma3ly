/// Application constants shared across all domains.
class AppConstants {
  AppConstants._();

  // ─── Timeouts ───────────────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // ─── Storage Keys ──────────────────────────────────────
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userRoleKey = 'user_role';
  static const String userDataKey = 'user_data';
  static const String localeKey = 'locale';

  // ─── Pagination ────────────────────────────────────────
  static const int defaultPageSize = 20;
}
