import 'package:dartz/dartz.dart';
import 'package:veggies/core/errors/failures.dart';
import 'package:veggies/data/entities/user_entity.dart';
import 'package:veggies/data/repositories/auth_repository.dart';


abstract class IAuthService {
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  );

  Future<Either<Failure, UserEntity?>> getCurrentUser();

  Future<Either<Failure, void>> signOut();
}
class AuthService implements IAuthService {
  AuthService(this.repository);
  final IAuthRepository repository;

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await repository.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    return await repository.signUpWithEmailAndPassword(email, password, name);
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    return await repository.getCurrentUser();
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    return await repository.signOut();
  }

}
