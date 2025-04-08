import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veggies/core/errors/failures.dart';
import 'package:veggies/data/entities/user_entity.dart';
import 'package:veggies/data/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements IAuthRepository {
  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    email,
    pass,
  ) async {
    if (email == 'test@123.com') {
      return Right(UserEntity(email: email, name: 'name'));
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    return Right(UserEntity(email: 'email', name: 'name'));
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    return const Right(null);
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailAndPassword(
    email,
    pass,
    name,
  ) async {
    return Right(UserEntity(email: email, name: 'name'));
  }
}

void main() {
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
  });

  final tFeatureEntity = UserEntity(email: 'email', name: 'name');

  test('should successfully retrieve current user from repository', () async {
    // arrange
    when(
      mockAuthRepository.getCurrentUser(),
    ).thenAnswer((_) async => Right(tFeatureEntity));

    // act
    final result = await mockAuthRepository.getCurrentUser();

    // assert
    expect(result, Right(tFeatureEntity));
    verify(mockAuthRepository.getCurrentUser());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return ServerFailure when auth repository fails', () async {
    // arrange
    when(
      mockAuthRepository.getCurrentUser(),
    ).thenAnswer((_) async => Left(ServerFailure()));

    // act
    final result = await mockAuthRepository.getCurrentUser();

    // assert
    expect(result, Left(ServerFailure()));
    verify(mockAuthRepository.getCurrentUser());
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
