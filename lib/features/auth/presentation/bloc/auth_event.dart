part of 'auth_bloc.dart';

@freezed
sealed class AuthEvent with _$AuthEvent {
  // ── Session lifecycle ──────────────────────────────────────────────────────
  /// Fired once at startup — reads token from secure storage.
  const factory AuthEvent.initialize() = _Initialize;

  /// Fired after a successful login to transition to authenticated.
  const factory AuthEvent.loggedIn() = _LoggedIn;

  /// Fired on logout — clears tokens and transitions to unauthenticated.
  const factory AuthEvent.loggedOut() = _LoggedOut;

  // ── Login form ─────────────────────────────────────────────────────────────
  const factory AuthEvent.login({
    required String username,
    required String password,
  }) = _Login;

  const factory AuthEvent.validate({
    String? username,
    String? password,
  }) = _Validate;
}
