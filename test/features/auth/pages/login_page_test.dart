import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veggies/data/entities/user_entity.dart';
import 'package:veggies/features/auth/bloc/auth_bloc.dart';
import 'package:veggies/features/auth/pages/login_page.dart';

class MockAuthBloc extends Mock implements AuthBloc {
  @override
  AuthState get state => super.noSuchMethod(
    Invocation.getter(#state),
    returnValue: AuthInitial(),
    returnValueForMissingStub: AuthInitial(),
  );
}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    when(mockAuthBloc.state).thenReturn(AuthLoading());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<MockAuthBloc>(
        create: (context) => mockAuthBloc,
        child: const LoginPage(),
      ),
    );
  }

  testWidgets('should show loading indicator when auth state is loading', (
    tester,
  ) async {
    // arrange
    when(mockAuthBloc.state).thenReturn(AuthLoading());
    // act
    await tester.pumpWidget(createWidgetUnderTest());
    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error message when auth state is failure', (
    tester,
  ) async {
    // arrange
    when(
      mockAuthBloc.state,
    ).thenReturn(const AuthFailure('Invalid credentials'));
    // act
    await tester.pumpWidget(createWidgetUnderTest());
    // assert
    expect(find.text('Invalid credentials'), findsOneWidget);
  });

  testWidgets('should navigate to home when auth state is authenticated', (
    tester,
  ) async {
    // arrange
    when(mockAuthBloc.state).thenReturn(
      AuthAuthenticated(UserEntity(id: 'userId123', email: 'user-email')),
    );
    // act
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();
    // assert
    expect(find.byType(LoginPage), findsNothing);
  });

  testWidgets('should validate email and password fields', (tester) async {
    // act
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.text('Sign In'));
    await tester.pump();
    // assert
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
  });

  testWidgets('should trigger SignInRequested event on valid input', (
    tester,
  ) async {
    // arrange
    final emailField = find.byType(TextFormField).first;
    final passwordField = find.byType(TextFormField).last;
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.enterText(emailField, 'test@123.com');
    await tester.enterText(passwordField, 'password123');
    // act
    await tester.tap(find.text('Sign In'));
    await tester.pump();
    // assert
    verify(
      mockAuthBloc.add(const SignInRequested('test@123.com', 'password123')),
    ).called(1);
  });

  testWidgets(
    'should navigate to signup page when "Create a New Account" is tapped',
    (tester) async {
      // arrange
      await tester.pumpWidget(createWidgetUnderTest());
      // act
      await tester.tap(find.text('Create a New Account'));
      await tester.pumpAndSettle();
      // assert
      expect(find.byType(LoginPage), findsNothing);
    },
  );

  testWidgets('should show validation error for invalid email format', (
    tester,
  ) async {
    // act
    await tester.pumpWidget(createWidgetUnderTest());
    final emailField = find.byType(TextFormField).first;
    await tester.enterText(emailField, 'invalid-email');
    await tester.tap(find.text('Sign In'));
    await tester.pump();
    // assert
    expect(find.text('Please enter a valid email'), findsOneWidget);
  });

  testWidgets('should show validation error for short password', (
    tester,
  ) async {
    // act
    await tester.pumpWidget(createWidgetUnderTest());
    final passwordField = find.byType(TextFormField).last;
    await tester.enterText(passwordField, '123');
    await tester.tap(find.text('Sign In'));
    await tester.pump();
    // assert
    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
  });

  // testWidgets('should dispose controllers and focus nodes on widget removal', (
  //   tester,
  // ) async {
  //   // arrange
  //   await tester.pumpWidget(createWidgetUnderTest());
  //   final state = tester.state(find.byType(LoginPage)) as _LoginPageState;
  //   // act
  //   state.dispose();
  //   // assert
  //   expect(() => state._emailController.text, throwsA(isA<Error>()));
  //   expect(() => state._passwordController.text, throwsA(isA<Error>()));
  //   expect(() => state._emailFocusNode.hasFocus, throwsA(isA<Error>()));
  //   expect(() => state._passwordFocusNode.hasFocus, throwsA(isA<Error>()));
  // });
}
