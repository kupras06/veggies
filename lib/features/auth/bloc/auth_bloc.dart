import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:veggies/data/entities/user_entity.dart';
import 'package:veggies/services/auth_services.dart';

part './auth_event.dart';
part './auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.authService,
  }) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }
  final IAuthService authService;

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    if (kDebugMode) {
      print('${event.email},${event.password}');
    }
    final result = await authService.signInWithEmailAndPassword(
      event.email,
      event.password,
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.toString())),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authService.signUpWithEmailAndPassword(
      event.email,
      event.password,
      event.name,
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.toString())),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authService.signOut();
    result.fold((failure) => emit(AuthFailure(failure.toString())), (_) {
      emit(AuthUnauthenticated());
    });
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authService.getCurrentUser();
    result.fold((failure) => emit(AuthFailure(failure.toString())), (user) {
      user == null
          ? emit(AuthUnauthenticated())
          : emit(AuthAuthenticated(user));
    });
  }

  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is UserDetailsRequested) {
      yield AuthLoading();
      final result = await authService.getCurrentUser();
      yield* result.fold(
        (failure) async* {
          yield AuthFailure(failure.message);
        },
        (user) async* {
          if (user != null) {
            yield AuthAuthenticated(user);
          } else {
            yield AuthUnauthenticated();
          }
        },
      );
    }
  }
}
