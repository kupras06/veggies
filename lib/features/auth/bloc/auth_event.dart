part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  const SignInRequested(this.email, this.password);
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  const SignUpRequested(this.email, this.password, this.name);
  final String email;
  final String password;
  final String name;

  @override
  List<Object> get props => [email, password, name];
}

class SignOutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

class UserDetailsRequested extends AuthEvent {}
