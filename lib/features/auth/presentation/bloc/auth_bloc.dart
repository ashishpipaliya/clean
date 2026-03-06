import 'dart:async';

import 'package:clean/core/error/error_handler.dart';
import 'package:clean/core/validation/validators.dart';
import 'package:clean/features/auth/domain/entity/login_response_entity.dart';
import 'package:clean/features/auth/domain/usecase/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;

  AuthBloc({
    required this.loginUsecase,
  }) : super(const AuthState.initial()) {
    on<_Login>(_onLogin);
    on<_Validate>(_onValidate);
  }

  Future<void> _onLogin(_Login event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    final response = await loginUsecase(username: event.username, password: event.password);

    response.fold(
      (failure) => emit(AuthState.failure(message: ErrorHandler.getErrorMessage(failure))),
      (entity) => emit(AuthState.success(loginResponse: entity)),
    );
  }

  FutureOr<void> _onValidate(_Validate event, Emitter<AuthState> emit) {
    bool isValidForm = Validators.isValidForm([Validators.username(event.username), Validators.password(event.password)]);
    emit(AuthState.validate(isFormValid: isValidForm));
  }
}
