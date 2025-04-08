import 'package:flutter/material.dart';
import 'package:veggies/features/auth/pages/login_page.dart';
import 'package:veggies/features/auth/pages/sign_up_page.dart';
import 'package:veggies/features/home/home_page.dart';

class AppRouter {
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No route defined for ${settings.name}'),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SignUpPage()),
                          );
                        },
                        child: const Text('Try Logging In'),
                      ),
                    ],
                  ),
                ),
              ),
        );
    }
  }
}
