import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_app/features/feature_name/presentation/bloc/feature_bloc.dart';
import 'package:my_app/features/feature_name/presentation/widgets/feature_widget.dart';

class MockFeatureBloc extends Mock implements FeatureBloc {}

void main() {
  late MockFeatureBloc mockFeatureBloc;

  setUp(() {
    mockFeatureBloc = MockFeatureBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<FeatureBloc>(
        create: (context) => mockFeatureBloc,
        child: const FeatureWidget(),
      ),
    );
  }

  testWidgets('should show loading indicator when state is loading', (
    tester,
  ) async {
    // arrange
    when(mockFeatureBloc.state).thenReturn(FeatureLoading());

    // act
    await tester.pumpWidget(createWidgetUnderTest());

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
