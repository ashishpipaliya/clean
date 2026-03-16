import 'package:clean/core/utils/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoggingInterceptor extends Interceptor {
  final AppLogger _logger;

  LoggingInterceptor(this._logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d(
      '[HTTP] → ${options.method} ${options.uri}\n'
      '  headers: ${_sanitizeHeaders(options.headers)}\n'
      '  body: ${options.data}',
    );
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d(
      '[HTTP] ← ${response.statusCode} ${response.requestOptions.uri}\n'
      '  body: ${response.data}',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      '[HTTP] ✕ ${err.response?.statusCode} ${err.requestOptions.uri}\n'
      '  message: ${err.message}\n'
      '  body: ${err.response?.data}',
      err,
      err.stackTrace,
    );
    handler.next(err);
  }

  /// Redacts the Authorization header value in logs.
  Map<String, dynamic> _sanitizeHeaders(Map<String, dynamic> headers) {
    final copy = Map<String, dynamic>.from(headers);
    if (copy.containsKey('Authorization')) {
      copy['Authorization'] = 'Bearer [redacted]';
    }
    return copy;
  }
}
