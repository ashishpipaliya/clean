import 'dart:async';

import 'package:clean/core/error/error_handler.dart';
import 'package:clean/core/validation/validators.dart';
import 'package:clean/features/auth/domain/entity/login_response_entity.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:clean/features/auth/domain/usecase/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

/// Single BLoC for all auth concerns:
/// - Session lifecycle (initialize, loggedIn, loggedOut) — router listens to these
/// - Login form (login, validate) — scoped to LoginPage
///
/// Registered as @singleton so the router can hold a reference for its
/// entire lifetime via refreshListenable.
@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final AuthRepository repository;

  AuthBloc({
    required this.loginUsecase,
    required this.repository}):
        super(const AuthState.unknown()) {
    on<_Initialize>(_onInitialize);
    on<_LoggedIn>(_onLoggedIn);
    on<_LoggedOut>(_onLoggedOut);
    on<_Login>(_onLogin);
    on<_Validate>(_onValidate);
  }

  // ── Session lifecycle ──────────────────────────────────────────────────────

  Future<void> _onInitialize(_Initialize event, Emitter<AuthState> emit) async {
    final isAuthenticated = await repository.isAuthenticated();
    emit(isAuthenticated
        ? const AuthState.authenticated()
        : const AuthState.unauthenticated());
  }

  void _onLoggedIn(_LoggedIn event, Emitter<AuthState> emit) {
    emit(const AuthState.authenticated());
  }

  Future<void> _onLoggedOut(_LoggedOut event, Emitter<AuthState> emit) async {
    await repository.clearTokens();
    emit(const AuthState.unauthenticated());
  }

  // ── Login form ─────────────────────────────────────────────────────────────

  Future<void> _onLogin(_Login event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    final response = await loginUsecase(
      username: event.username,
      password: event.password,
    );

    response.fold(
      (failure) => emit(
        AuthState.loginFailure(message: ErrorHandler.getErrorMessage(failure)),
      ),
      (entity) => emit(AuthState.loginSuccess(loginResponse: entity)),
    );
  }

  FutureOr<void> _onValidate(_Validate event, Emitter<AuthState> emit) {
    final isValid = Validators.isValidForm([
      Validators.username(event.username),
      Validators.password(event.password),
    ]);
    emit(AuthState.validate(isFormValid: isValid));
  }
}
