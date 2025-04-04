import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:veggies/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter', (
      tester,
    ) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify the initial state
      expect(find.text('0'), findsOneWidget);

      // Find and tap the FAB
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      // Verify the counter incremented
      expect(find.text('1'), findsOneWidget);
    });
  });
}
