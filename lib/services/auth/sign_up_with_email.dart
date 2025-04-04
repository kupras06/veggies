import 'package:dartz/dartz.dart';
import 'package:veggies/core/errors/failures.dart';
import 'package:veggies/data/entities/user_entity.dart';
import 'package:veggies/data/repositories/auth_repository.dart';

class SignUpWithEmail {
  SignUpWithEmail(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, UserEntity>> call(
    String email,
    String password,
    String name,
  ) async {
    return await repository.signUpWithEmailAndPassword(email, password, name);
  }
}
