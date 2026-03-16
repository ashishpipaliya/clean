import 'package:clean/core/network/interceptors/auth_interceptor.dart';
import 'package:clean/core/network/interceptors/logging_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor, LoggingInterceptor loggingInterceptor) {
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

    // RefreshTokenInterceptor is inserted after DI graph is built (injection.dart)
    // to avoid a circular dependency with Dio.
    dio.interceptors.addAll([authInterceptor, loggingInterceptor]);

    return dio;
  }
}
