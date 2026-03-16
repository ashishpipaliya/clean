import 'package:clean/core/network/interceptors/refresh_token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();

  // Add RefreshTokenInterceptor after the graph is built so Dio and the
  // interceptor can both be singletons without a circular dependency.
  // Insert before LogInterceptor (last) so refresh happens transparently.
  final dio = getIt<Dio>();
  final refreshInterceptor = getIt<RefreshTokenInterceptor>();
  dio.interceptors.add(refreshInterceptor);
}
