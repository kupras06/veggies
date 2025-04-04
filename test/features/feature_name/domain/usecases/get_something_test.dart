import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:veggies/core/errors/failures.dart';
import 'package:veggies/features/feature_name/domain/entities/feature_entity.dart';
import 'package:veggies/features/feature_name/domain/repositories/feature_repository.dart';
import 'package:veggies/features/feature_name/domain/usecases/get_something.dart';

class MockFeatureRepository extends Mock implements FeatureRepository {}

void main() {
  late GetSomething usecase;
  late MockFeatureRepository mockFeatureRepository;

  setUp(() {
    mockFeatureRepository = MockFeatureRepository();
    usecase = GetSomething(mockFeatureRepository);
  });

  final tFeatureEntity = FeatureEntity();

  test('should get feature data from the repository', () async {
    // arrange
    when(
      mockFeatureRepository.getSomething(),
    ).thenAnswer((_) async => Right(tFeatureEntity));

    // act
    final result = await usecase();

    // assert
    expect(result, Right(tFeatureEntity));
    verify(mockFeatureRepository.getSomething());
    verifyNoMoreInteractions(mockFeatureRepository);
  });

  test('should return ServerFailure when repository fails', () async {
    // arrange
    when(
      mockFeatureRepository.getSomething(),
    ).thenAnswer((_) async => Left(ServerFailure()));

    // act
    final result = await usecase();

    // assert
    expect(result, Left(ServerFailure()));
    verify(mockFeatureRepository.getSomething());
    verifyNoMoreInteractions(mockFeatureRepository);
  });
}
