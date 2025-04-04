import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggies/core/routes/app_router.dart';
import 'package:veggies/features/auth/bloc/auth_bloc.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.home,
              (route) => false,
            );
          });
          return const Center(
            child: CircularProgressIndicator(color: Colors.black12),
          );
        } else if (state is AuthUnauthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouter.login,
              (route) => false,
            );
          });
          return const Center(
            child: CircularProgressIndicator(color: Colors.black12),
          );
        }
        return const Center(child: Text('Waiting'));
      },
    );
  }
}
