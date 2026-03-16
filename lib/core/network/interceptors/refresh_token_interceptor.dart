import 'package:clean/core/storage/secure_storage_service.dart';
import 'package:clean/core/utils/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RefreshTokenInterceptor extends Interceptor {
  final Dio _dio;
  final SecureStorageService _secureStorage;
  final AppLogger _logger;

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _retryKey = '_retry';

  RefreshTokenInterceptor(this._dio, this._secureStorage, this._logger);

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final isRetry = err.requestOptions.extra[_retryKey] == true;
    final is401 = err.response?.statusCode == 401;

    if (!is401 || isRetry) return handler.next(err);

    final refreshToken = await _secureStorage.read(_refreshTokenKey);
    if (refreshToken == null || refreshToken.isEmpty) return handler.next(err);

    try {
      _logger.i('[RefreshToken] Refreshing...');
      final res = await _dio.post<Map<String, dynamic>>(
        '/auth/refresh',
        data: {'refreshToken': refreshToken},
        options: Options(headers: {'Authorization': null}, extra: {_retryKey: true}),
      );

      final newToken = res.data?['accessToken'] as String? ?? '';
      if (newToken.isEmpty) throw Exception('Empty token');

      await _secureStorage.write(_accessTokenKey, newToken);
      _logger.i('[RefreshToken] Token refreshed');

      final retried = await _dio.request<dynamic>(
        err.requestOptions.path,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
        options: Options(
          method: err.requestOptions.method,
          headers: {...err.requestOptions.headers, 'Authorization': 'Bearer $newToken'},
          extra: {...err.requestOptions.extra, _retryKey: true},
        ),
      );
      handler.resolve(retried);
    } catch (e) {
      _logger.e('[RefreshToken] Failed — clearing tokens', e);
      await _secureStorage.delete(_accessTokenKey);
      await _secureStorage.delete(_refreshTokenKey);
      handler.next(err);
    }
  }
}
