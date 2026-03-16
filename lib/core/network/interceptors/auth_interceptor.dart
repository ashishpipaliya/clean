import 'package:clean/core/storage/secure_storage_service.dart';
import 'package:clean/core/utils/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

/// Attaches the Authorization header to every outgoing request.
/// Refresh token logic is handled separately in [RefreshTokenInterceptor].
@lazySingleton
class AuthInterceptor extends Interceptor {
  final SecureStorageService _secureStorage;
  final AppLogger _logger;

  static const _accessTokenKey = 'access_token';

  AuthInterceptor(this._secureStorage, this._logger);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.read(_accessTokenKey);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      _logger.d('[AuthInterceptor] Token attached');
    }
    handler.next(options);
  }
}
