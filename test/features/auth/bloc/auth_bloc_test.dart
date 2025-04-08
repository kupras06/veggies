import 'package:test/test.dart';
import 'package:veggies/data/entities/user_entity.dart';
import 'package:veggies/features/auth/bloc/auth_bloc.dart';
import 'package:veggies/services/auth_services.dart';

import '../../../data/repository/auth_repository_test.dart';

void main() {
  group(AuthBloc, () {
    late AuthBloc authBloc;

    setUp(() {
      authBloc = AuthBloc(
        authService: AuthService(MockAuthRepository()),
      );
    });

    test('initial state of AuthInitial', () {
      expect(authBloc.state, AuthInitial());
    });

    test('check for Authenticated State', () async {
      final userEntity = UserEntity(email: 'test@123.com', name: 'name');
      authBloc.add(const SignInRequested('test@123.com', '123456'));
      await expectLater(
        authBloc.stream,
        emitsInOrder([AuthLoading(), AuthAuthenticated(userEntity)]),
      );
    });

    test('check for SignOut State', () async {
      authBloc.add(SignOutRequested());
      await expectLater(
        authBloc.stream,
        emitsInOrder([AuthLoading(), AuthUnauthenticated()]),
      );
    });

    test('check for SignUp State', () async {
      final userEntity = UserEntity(email: 'newuser@123.com', name: 'New User');
      authBloc.add(
        const SignUpRequested('newuser@123.com', 'password123', 'New User'),
      );
      await expectLater(
        authBloc.stream,
        emitsInOrder([AuthLoading(), AuthAuthenticated(userEntity)]),
      );
    });

    test('check for AuthFailure on invalid credentials', () async {
      authBloc.add(const SignInRequested('invalid@123.com', 'wrongpassword'));
      await expectLater(
        authBloc.stream,
        emitsInOrder([AuthLoading(), isA<AuthFailure>()]),
      );
    });

    test('check for current user status', () async {
      authBloc.add(CheckAuthStatus());
      await expectLater(
        authBloc.stream,
        emitsInOrder([AuthLoading(), isA<AuthAuthenticated>()]),
      );
    });
  });
}
