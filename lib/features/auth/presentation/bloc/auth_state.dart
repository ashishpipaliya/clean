part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  // ── Session states (router listens to these) ───────────────────────────────
  /// Initial state before storage has been read.
  const factory AuthState.unknown() = _Unknown;

  const factory AuthState.authenticated() = _Authenticated;

  const factory AuthState.unauthenticated() = _Unauthenticated;

  // ── Login form states ──────────────────────────────────────────────────────
  const factory AuthState.loading() = _Loading;

  const factory AuthState.loginSuccess({
    required LoginResponseEntity loginResponse,
  }) = _LoginSuccess;

  const factory AuthState.loginFailure({required String message}) = _LoginFailure;

  const factory AuthState.validate({required bool isFormValid}) = _FormValidate;
}
