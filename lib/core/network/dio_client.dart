import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../error/failures.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    return dio;
  }
}

/// Network error handler utility
class NetworkErrorHandler {
  NetworkErrorHandler._();

  /// Convert DioException to Failure
  static Failure handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return const Failure.network(
            'Connection timeout. Please check your internet connection.',
          );

        case DioExceptionType.badResponse:
          return _handleResponseError(error.response);

        case DioExceptionType.cancel:
          return const Failure.network('Request was cancelled.');

        case DioExceptionType.connectionError:
          return const Failure.network(
            'No internet connection. Please check your network settings.',
          );

        case DioExceptionType.badCertificate:
          return const Failure.network(
            'Security certificate error. Please try again later.',
          );

        case DioExceptionType.unknown:
          if (error.message?.contains('SocketException') ?? false) {
            return const Failure.network(
              'No internet connection. Please check your network settings.',
            );
          }
          return Failure.unknown(
            error.message ?? 'An unexpected error occurred.',
          );
      }
    }

    // Handle non-Dio errors
    return Failure.unknown(error.toString());
  }

  /// Handle HTTP response errors
  static Failure _handleResponseError(Response? response) {
    if (response == null) {
      return const Failure.server('Server error. Please try again later.');
    }

    final statusCode = response.statusCode ?? 0;
    final message = _extractErrorMessage(response.data);

    switch (statusCode) {
      case 400:
        return Failure.validation(message ?? 'Invalid request.');
      case 401:
        return Failure.unauthorized(
          message ?? 'Unauthorized. Please login again.',
        );
      case 403:
        return Failure.unauthorized(
          message ?? 'Access forbidden.',
        );
      case 404:
        return Failure.server(message ?? 'Resource not found.');
      case 408:
        return const Failure.network('Request timeout. Please try again.');
      case 429:
        return const Failure.server(
          'Too many requests. Please try again later.',
        );
      case 500:
      case 502:
      case 503:
      case 504:
        return Failure.server(
          message ?? 'Server error. Please try again later.',
        );
      default:
        if (statusCode >= 500) {
          return Failure.server(
            message ?? 'Server error. Please try again later.',
          );
        }
        return Failure.unknown(
          message ?? 'An unexpected error occurred.',
        );
    }
  }

  /// Extract error message from response data
  static String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    if (data is Map<String, dynamic>) {
      // Try common error message keys
      return data['message'] as String? ??
          data['error'] as String? ??
          data['msg'] as String? ??
          data['detail'] as String?;
    }

    if (data is String) {
      return data;
    }

    return null;
  }
}
