import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Logs HTTP requests and responses for debugging.
///
/// Only active when logging is enabled via [EnvConfig].
class LoggingInterceptor extends Interceptor {
  final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 0, dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i(
      '→ ${options.method} ${options.uri}\n'
      'Headers: ${options.headers}\n'
      'Data: ${options.data}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d(
      '← ${response.statusCode} ${response.requestOptions.uri}\n'
      'Data: ${response.data}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      '✖ ${err.response?.statusCode} ${err.requestOptions.uri}\n'
      'Message: ${err.message}\n'
      'Data: ${err.response?.data}',
    );
    handler.next(err);
  }
}
