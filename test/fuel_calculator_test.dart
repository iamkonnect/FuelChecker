import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fuel_checker/widgets/fuel_calculator.dart'; // Updated package name

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

    testWidgets('handles zero values correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: FuelCalculator(),
        ),
      ));

      await tester.enterText(find.byType(TextField).first, '0');
      await tester.enterText(find.byType(TextField).last, '0');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Total: \$0.00'), findsOneWidget);
    });

    testWidgets('handles decimal values correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: FuelCalculator(),
        ),
      ));

      await tester.enterText(find.byType(TextField).first, '1.99');
      await tester.enterText(find.byType(TextField).last, '15.5');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Total: \$30.85'), findsOneWidget);
    });

    testWidgets('handles invalid input', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: FuelCalculator(),
        ),
      ));

      await tester.enterText(find.byType(TextField).first, 'abc');
      await tester.enterText(find.byType(TextField).last, 'xyz');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Total: \$0.00'), findsOneWidget);
    });

    testWidgets('handles large numbers', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: FuelCalculator(),
        ),
      ));

      await tester.enterText(find.byType(TextField).first, '9999999.99');
      await tester.enterText(find.byType(TextField).last, '9999999.99');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Debug output
      print('Entered price: 9999999.99');
      print('Entered liters: 9999999.99');

      expect(find.text('Total: \$99999999980000.00'), findsOneWidget);
    });

    testWidgets('handles empty input', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: FuelCalculator(),
        ),
      ));

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Total: \$0.00'), findsOneWidget);
    });
  });
}
