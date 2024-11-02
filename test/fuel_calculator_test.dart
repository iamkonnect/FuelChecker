import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuel_checker/widgets/fuel_calculator.dart';

void main() {
  group('FuelCalculator Widget', () {
    testWidgets('calculates total correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: FuelCalculator(),
        ),
      ));

      // Enter test values
      await tester.enterText(find.byType(TextField).first, '2.5');
      await tester.enterText(find.byType(TextField).last, '40');

      // Tap calculate button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify the result
      expect(find.text('Total: \$100.00'), findsOneWidget);
    });
  });
}