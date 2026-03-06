part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent{
  const factory AuthEvent.login({required String username, required String password}) = _Login;
  const factory AuthEvent.validate({ String? username,  String? password}) = _Validate;
}