import 'package:clean/core/error/error_handler.dart';
import 'package:clean/core/error/failures.dart';
import 'package:clean/core/storage/secure_storage_service.dart';
import 'package:clean/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:clean/features/auth/data/model/login_request.dart';
import 'package:clean/features/auth/data/model/login_response_mapper.dart';
import 'package:clean/features/auth/domain/entity/login_response_entity.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final SecureStorageService secureStorageService;

  // Storage keys
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  AuthRepositoryImpl(this.authRemoteDataSource, this.secureStorageService);

  @override
  Future<Either<Failure, LoginResponseEntity>> login({required String username, required String password, int? expiresInMins = 30}) async {
    final LoginRequest loginRequest = LoginRequest(username: username, password: password, expiresInMins: expiresInMins);

    try {
      final response = await authRemoteDataSource.login(loginRequest);
      final entity = response.toEntity();

      // Store tokens in secure storage
      if (entity.accessToken != null) {
        await secureStorageService.write(_accessTokenKey, entity.accessToken!);
      }
      if (entity.refreshToken != null) {
        await secureStorageService.write(_refreshTokenKey, entity.refreshToken!);
      }

      return Right(entity);
    } catch (e) {
      return Left(ErrorHandler.handleException(e));
    }
  }

  /// Check if user is authenticated
  @override
  Future<bool> isAuthenticated() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  /// Get stored access token
  @override
  Future<String?> getAccessToken() async {
    return await secureStorageService.read(_accessTokenKey);
  }

  /// Get stored refresh token
  @override
  Future<String?> getRefreshToken() async {
    return await secureStorageService.read(_refreshTokenKey);
  }

  /// Clear stored tokens (logout)
  @override
  Future<void> clearTokens() async {
    await secureStorageService.delete(_accessTokenKey);
    await secureStorageService.delete(_refreshTokenKey);
  }
}
