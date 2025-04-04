import 'package:dartz/dartz.dart';
import 'package:veggies/core/errors/failures.dart';
import 'package:veggies/data/entities/user_entity.dart';
import 'package:veggies/data/repositories/auth_repository.dart';

class SignInWithEmail {
  SignInWithEmail(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, UserEntity>> call(
    String email,
    String password,
  ) async {
    return await repository.signInWithEmailAndPassword(email, password);
  }
}
