part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent{
  const factory AuthEvent.login({required String email, required String password}) = _Login;
}