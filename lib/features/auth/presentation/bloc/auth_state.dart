part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.success({required LoginResponseEntity loginResponse}) = Success;
  const factory AuthState.failure({required String message}) = Failure;

  /// Login form validation state
  const factory AuthState.validate({required bool isFormValid}) = Validate;
}
