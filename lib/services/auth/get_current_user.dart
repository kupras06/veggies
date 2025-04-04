import 'package:dartz/dartz.dart';
import 'package:veggies/core/errors/failures.dart';
import 'package:veggies/data/entities/user_entity.dart';
import 'package:veggies/data/repositories/auth_repository.dart';

class GetCurrentUser {
  GetCurrentUser(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, UserEntity?>> call() async {
    return await repository.getCurrentUser();
  }
}
