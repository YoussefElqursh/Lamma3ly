/// Application environment configuration.
///
/// Defines environment-specific settings such as base URL, app name,
/// and feature flags. Used by entry points to bootstrap the app.
enum Environment { dev, staging, prod }

class EnvConfig {
  final Environment environment;
  final String baseUrl;
  final String appName;
  final bool enableLogging;

  const EnvConfig({
    required this.environment,
    required this.baseUrl,
    required this.appName,
    this.enableLogging = false,
  });

  static const EnvConfig dev = EnvConfig(
    environment: Environment.dev,
    baseUrl: 'https://dev-api.lamma3ly.com/api/v1',
    appName: 'Lamma3ly Dev',
    enableLogging: true,
  );

  static const EnvConfig staging = EnvConfig(
    environment: Environment.staging,
    baseUrl: 'https://staging-api.lamma3ly.com/api/v1',
    appName: 'Lamma3ly Staging',
    enableLogging: true,
  );

  static const EnvConfig prod = EnvConfig(
    environment: Environment.prod,
    baseUrl: 'https://api.lamma3ly.com/api/v1',
    appName: 'Lamma3ly',
    enableLogging: false,
  );

  bool get isDev => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProd => environment == Environment.prod;
}
