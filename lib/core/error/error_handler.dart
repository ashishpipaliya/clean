// ignore_for_file: unintended_html_in_doc_comment

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'exceptions.dart';
import 'failures.dart';

/// Unified error handler that converts any exception to Failure
class ErrorHandler {
  ErrorHandler._();

  /// Convert any exception to Failure
  static Failure handleException(dynamic error) {
    return switch (error) {
      ServerException() => Failure.server(error.message),
      NetworkException() => Failure.network(error.message),
      CacheException() => Failure.cache(error.message),
      UnauthorizedException() => Failure.unauthorized(error.message),
      DioException() => _handleDioException(error),
      Failure() => error,
      _ => Failure.unknown(error.toString()),
    };
  }

  /// Handle Dio-specific errors
  static Failure _handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure.network('Connection timeout. Please check your internet.');

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return const Failure.unknown('Request cancelled');
      case DioExceptionType.connectionError:
        return const Failure.network('No internet connection');
      case DioExceptionType.badCertificate:
        return const Failure.network('Certificate verification failed');
      case DioExceptionType.unknown:
        return Failure.unknown(error.message ?? 'Unknown error occurred');
    }
  }

  /// Handle HTTP response errors
  static Failure _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final message = _extractErrorMessage(error.response?.data);

    switch (statusCode) {
      case 400:
        return Failure.validation(message ?? 'Invalid request');
      case 401:
        return Failure.unauthorized(message ?? 'Unauthorized access');
      case 403:
        return Failure.unauthorized(message ?? 'Access forbidden');
      case 404:
        return Failure.server(message ?? 'Resource not found');
      case 500:
      case 502:
      case 503:
        return Failure.server(message ?? 'Server error. Please try again later.');
      default:
        return Failure.server(message ?? 'Something went wrong');
    }
  }

  /// Extract error message from response data
  static String? _extractErrorMessage(dynamic data) {
    if (data == null) return null;

    if (data is Map) {
      // Try common error message keys
      return data['message'] ?? data['error'] ?? data['msg'] ?? data['detail'];
    }

    if (data is String) {
      return data;
    }

    return null;
  }

  /// Get user-friendly error message from Failure
  static String getErrorMessage(Failure failure) {
    return failure.when(
      server: (msg) => msg,
      network: (msg) => msg,
      cache: (msg) => msg,
      validation: (msg) => msg,
      unauthorized: (msg) => msg,
      unknown: (msg) => msg,
    );
  }
}

/// Extension to easily convert exceptions to Left(Failure)
extension ExceptionToFailure on Exception {
  Left<Failure, T> toLeft<T>() {
    return Left(ErrorHandler.handleException(this));
  }
}

/// Extension to safely execute async operations and handle errors
extension SafeCall<T> on Future<T> {
  /// Execute and automatically convert exceptions to Either<Failure, T>
  Future<Either<Failure, T>> toEither() async {
    try {
      final result = await this;
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }
}

/// Extension to safely execute sync operations and handle errors
extension SafeCallSync<T> on T Function() {
  /// Execute and automatically convert exceptions to Either<Failure, T>
  Either<Failure, T> toEither() {
    try {
      final result = this();
      return Right(result);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }
}
