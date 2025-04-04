import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggies/core/routes/app_router.dart';
import 'package:veggies/features/auth/bloc/auth_bloc.dart';

class RouteGuard extends StatelessWidget {
  const RouteGuard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRouter.login,
            (route) => false,
          );
        }
      },
      child: child,
    );
  }
}
