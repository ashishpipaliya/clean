// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean/core/navigation/navigation_service.dart' as _i339;
import 'package:clean/core/network/connectivity_service.dart' as _i431;
import 'package:clean/core/network/dio_client.dart' as _i581;
import 'package:clean/core/storage/hive_service.dart' as _i156;
import 'package:clean/core/storage/secure_storage_service.dart' as _i107;
import 'package:clean/features/auth/data/datasource/auth_remote_data_source.dart'
    as _i116;
import 'package:clean/features/auth/data/repository/auth_repository_impl.dart'
    as _i62;
import 'package:clean/features/auth/domain/repository/auth_repository.dart'
    as _i558;
import 'package:clean/features/auth/domain/usecase/login_usecase.dart' as _i854;
import 'package:clean/features/auth/presentation/bloc/auth_bloc.dart' as _i1055;
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
    final networkModule = _$NetworkModule();
    final secureStorageModule = _$SecureStorageModule();
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
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => secureStorageModule.secureStorage,
    );
    gh.factory<_i116.AuthRemoteDataSource>(
      () => _i116.AuthRemoteDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i339.NavigationService>(
      () =>
          _i339.NavigationService(gh<_i409.GlobalKey<_i409.NavigatorState>>()),
    );
    gh.lazySingleton<_i431.ConnectivityService>(
      () => _i431.ConnectivityService(
        gh<_i161.InternetConnection>(),
        gh<_i339.NavigationService>(),
      ),
    );
    gh.lazySingleton<_i107.SecureStorageService>(
      () => _i107.SecureStorageService(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i156.HiveService>(
      () => _i156.HiveService(gh<_i738.HiveInterface>()),
    );
    gh.factory<_i558.AuthRepository>(
      () => _i62.AuthRepositoryImpl(
        gh<_i116.AuthRemoteDataSource>(),
        gh<_i107.SecureStorageService>(),
      ),
    );
    gh.factory<_i854.LoginUsecase>(
      () => _i854.LoginUsecase(gh<_i558.AuthRepository>()),
    );
    gh.factory<_i1055.AuthBloc>(
      () => _i1055.AuthBloc(loginUsecase: gh<_i854.LoginUsecase>()),
    );
    return this;
  }
}

class _$HiveModule extends _i156.HiveModule {}

class _$NavigationModule extends _i339.NavigationModule {}

class _$ConnectivityModule extends _i431.ConnectivityModule {}

class _$NetworkModule extends _i581.NetworkModule {}

class _$SecureStorageModule extends _i107.SecureStorageModule {}
