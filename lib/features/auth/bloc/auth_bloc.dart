import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:veggies/services/auth/get_current_user.dart';
import 'package:veggies/services/auth/sign_out.dart';
import 'package:veggies/services/auth/sign_up_with_email.dart';

import '../../../data/entities/user_entity.dart';
import '../../../services/auth/sign_in_with_email.dart';

part './auth_event.dart';
part './auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.signInWithEmail,
    required this.signUpWithEmail,
    required this.getCurrentUser,
    required this.signOut,
  }) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }
  final SignInWithEmail signInWithEmail;
  final SignUpWithEmail signUpWithEmail;
  final GetCurrentUser getCurrentUser;
  final SignOut signOut;

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await signInWithEmail(event.email, event.password);
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
    final result = await signUpWithEmail(
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
    final result = await signOut();
    result.fold((failure) => emit(AuthFailure(failure.toString())), (_) {
      emit(AuthUnauthenticated());
    });
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await getCurrentUser();
    result.fold((failure) => emit(AuthFailure(failure.toString())), (user) {
      user == null
          ? emit(AuthUnauthenticated())
          : emit(AuthAuthenticated(user));
    });
  }

  // Implement other event handlers similarly
}
