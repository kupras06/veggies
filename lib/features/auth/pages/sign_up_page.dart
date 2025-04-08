import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veggies/core/routes/app_router.dart';
import 'package:veggies/features/auth/bloc/auth_bloc.dart';
import 'package:veggies/features/auth/widgets/auth_layout.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: AuthLayout(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              spacing: 10,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                TextField(
                  controller: _nameController,

                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          SignUpRequested(
                            _emailController.text,
                            _passwordController.text,
                            _nameController.text,
                          ),
                        );
                      },
                      child: const Text('Create Account'),
                    ),
                    TextButton(
                      onPressed:
                          () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRouter.login,
                            (route) => false,
                          ),
                      child: const Text('Already have an account?'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
