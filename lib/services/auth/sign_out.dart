import 'package:dartz/dartz.dart';
import 'package:veggies/core/errors/failures.dart';
import 'package:veggies/data/repositories/auth_repository.dart';

class SignOut {
  SignOut(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, void>> call() async {
    return await repository.signOut();
  }
}
