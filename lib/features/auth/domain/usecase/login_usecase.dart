import 'package:clean/core/error/failures.dart';
import 'package:clean/features/auth/domain/entity/login_response_entity.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase(this.authRepository);

  Future<Either<Failure, LoginResponseEntity>> call({required String username, required String password, int? expiresInMins}){
    return authRepository.login(username: username, password: password, expiresInMins: expiresInMins);
  }
}