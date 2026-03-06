import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';

@injectable
class LogoutUsecase {
  final AuthRepository _authRepository;

  LogoutUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call() async {
    try {
      await _authRepository.clearTokens();
      return right(unit);
    } catch (e) {
      return left(const CacheFailure('Failed to logout'));
    }
  }
}
