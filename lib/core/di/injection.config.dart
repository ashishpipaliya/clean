// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean/core/monitoring/crash_reporting_service.dart' as _i969;
import 'package:clean/core/monitoring/mock_crash_reporting_service.dart'
    as _i145;
import 'package:clean/core/navigation/navigation_service.dart' as _i339;
import 'package:clean/core/network/connectivity_service.dart' as _i431;
import 'package:clean/core/network/dio_client.dart' as _i581;
import 'package:clean/core/network/interceptors/auth_interceptor.dart' as _i212;
import 'package:clean/core/network/interceptors/logging_interceptor.dart'
    as _i726;
import 'package:clean/core/network/interceptors/refresh_token_interceptor.dart'
    as _i499;
import 'package:clean/core/security/encryption_service.dart' as _i601;
import 'package:clean/core/storage/hive_service.dart' as _i156;
import 'package:clean/core/storage/secure_storage_service.dart' as _i107;
import 'package:clean/core/utils/app_logger.dart' as _i367;
import 'package:clean/features/auth/data/datasource/auth_remote_data_source.dart'
    as _i116;
import 'package:clean/features/auth/data/repository/auth_repository_impl.dart'
    as _i62;
import 'package:clean/features/auth/domain/repository/auth_repository.dart'
    as _i558;
import 'package:clean/features/auth/domain/usecase/login_usecase.dart' as _i854;
import 'package:clean/features/auth/presentation/bloc/auth_bloc.dart' as _i1055;
import 'package:clean/features/home/data/datasource/home_local_data_source.dart'
    as _i947;
import 'package:clean/features/home/data/datasource/home_remote_data_source.dart'
    as _i1055;
import 'package:clean/features/home/data/repository/home_repository_impl.dart'
    as _i837;
import 'package:clean/features/home/domain/repository/home_repository.dart'
    as _i236;
import 'package:clean/features/home/domain/usecase/get_home_detail_usecase.dart'
    as _i805;
import 'package:clean/features/home/domain/usecase/get_home_list_usecase.dart'
    as _i891;
import 'package:clean/features/home/presentation/bloc/home_bloc.dart' as _i273;
import 'package:clean/features/home/presentation/bloc/pokemon_detail_bloc.dart'
    as _i601;
import 'package:clean/features/settings/data/datasource/settings_local_data_source.dart'
    as _i617;
import 'package:clean/features/settings/data/repository/settings_repository_impl.dart'
    as _i1049;
import 'package:clean/features/settings/domain/repository/settings_repository.dart'
    as _i88;
import 'package:clean/features/settings/domain/usecase/logout_usecase.dart'
    as _i79;
import 'package:clean/features/settings/presentation/bloc/settings_bloc.dart'
    as _i44;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/material.dart' as _i409;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce/hive.dart' as _i738;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final hiveModule = _$HiveModule();
    final navigationModule = _$NavigationModule();
    final connectivityModule = _$ConnectivityModule();
    final secureStorageModule = _$SecureStorageModule();
    final networkModule = _$NetworkModule();
    await gh.singletonAsync<_i738.HiveInterface>(
      () => hiveModule.hive,
      preResolve: true,
    );
    gh.lazySingleton<_i409.GlobalKey<_i409.NavigatorState>>(
      () => navigationModule.navigatorKey,
    );
    gh.lazySingleton<_i161.InternetConnection>(
      () => connectivityModule.internetConnection,
    );
    gh.lazySingleton<_i601.EncryptionService>(() => _i601.EncryptionService());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => secureStorageModule.secureStorage,
    );
    gh.lazySingleton<_i367.AppLogger>(() => _i367.AppLogger());
    gh.factory<_i947.HomeLocalDataSource>(
      () => _i947.HomeLocalDataSource(gh<_i601.EncryptionService>()),
    );
    gh.lazySingleton<_i431.ConnectivityService>(
      () => _i431.ConnectivityService(
        gh<_i161.InternetConnection>(),
        gh<_i409.GlobalKey<_i409.NavigatorState>>(),
      ),
    );
    gh.lazySingleton<_i339.NavigationService>(
      () =>
          _i339.NavigationService(gh<_i409.GlobalKey<_i409.NavigatorState>>()),
    );
    gh.lazySingleton<_i107.SecureStorageService>(
      () => _i107.SecureStorageService(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i212.AuthInterceptor>(
      () => _i212.AuthInterceptor(
        gh<_i107.SecureStorageService>(),
        gh<_i367.AppLogger>(),
      ),
    );
    gh.lazySingleton<_i726.LoggingInterceptor>(
      () => _i726.LoggingInterceptor(gh<_i367.AppLogger>()),
    );
    gh.lazySingleton<_i969.CrashReportingService>(
      () => _i145.MockCrashReportingService(gh<_i367.AppLogger>()),
    );
    gh.lazySingleton<_i156.HiveService>(
      () => _i156.HiveService(gh<_i738.HiveInterface>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => networkModule.dio(
        gh<_i212.AuthInterceptor>(),
        gh<_i726.LoggingInterceptor>(),
      ),
    );
    gh.lazySingleton<_i617.SettingsLocalDataSource>(
      () => _i617.SettingsLocalDataSource(gh<_i107.SecureStorageService>()),
    );
    gh.factory<_i88.SettingsRepository>(
      () => _i1049.SettingsRepositoryImpl(gh<_i617.SettingsLocalDataSource>()),
    );
    gh.lazySingleton<_i499.RefreshTokenInterceptor>(
      () => _i499.RefreshTokenInterceptor(
        gh<_i361.Dio>(),
        gh<_i107.SecureStorageService>(),
        gh<_i367.AppLogger>(),
      ),
    );
    gh.factory<_i116.AuthRemoteDataSource>(
      () => _i116.AuthRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.factory<_i1055.HomeRemoteDataSource>(
      () => _i1055.HomeRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.factory<_i236.HomeRepository>(
      () => _i837.HomeRepositoryImpl(
        gh<_i1055.HomeRemoteDataSource>(),
        gh<_i947.HomeLocalDataSource>(),
      ),
    );
    gh.factory<_i558.AuthRepository>(
      () => _i62.AuthRepositoryImpl(
        gh<_i116.AuthRemoteDataSource>(),
        gh<_i107.SecureStorageService>(),
      ),
    );
    gh.factory<_i805.GetHomeDetailUsecase>(
      () => _i805.GetHomeDetailUsecase(gh<_i236.HomeRepository>()),
    );
    gh.factory<_i891.GetHomeListUsecase>(
      () => _i891.GetHomeListUsecase(gh<_i236.HomeRepository>()),
    );
    gh.factory<_i601.PokemonDetailBloc>(
      () => _i601.PokemonDetailBloc(gh<_i805.GetHomeDetailUsecase>()),
    );
    gh.factory<_i854.LoginUsecase>(
      () => _i854.LoginUsecase(gh<_i558.AuthRepository>()),
    );
    gh.factory<_i79.LogoutUsecase>(
      () => _i79.LogoutUsecase(gh<_i558.AuthRepository>()),
    );
    gh.factory<_i273.HomeBloc>(
      () => _i273.HomeBloc(gh<_i891.GetHomeListUsecase>()),
    );
    gh.factory<_i1055.AuthBloc>(
      () => _i1055.AuthBloc(loginUsecase: gh<_i854.LoginUsecase>()),
    );
    gh.singleton<_i44.SettingsBloc>(
      () => _i44.SettingsBloc(
        gh<_i88.SettingsRepository>(),
        gh<_i79.LogoutUsecase>(),
      ),
    );
    return this;
  }
}

class _$HiveModule extends _i156.HiveModule {}

class _$NavigationModule extends _i339.NavigationModule {}

class _$ConnectivityModule extends _i431.ConnectivityModule {}

class _$SecureStorageModule extends _i107.SecureStorageModule {}

class _$NetworkModule extends _i581.NetworkModule {}
