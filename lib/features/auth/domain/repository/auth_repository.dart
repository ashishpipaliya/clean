import 'package:clean/core/error/failures.dart';
import 'package:clean/features/auth/domain/entity/login_response_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponseEntity>> login({required String username, required String password, int expiresInMins = 30});

  /// Check if user is authenticated
  Future<bool> isAuthenticated();

  /// Get stored access token
  Future<String?> getAccessToken();

  /// Get stored refresh token
  Future<String?> getRefreshToken();

  /// Clear stored tokens (logout)
  Future<Either<Failure, Unit>> clearTokens();
}
