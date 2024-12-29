import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_first_flutter_app/screens/fuel_map_screen.dart';

void main() {
  testWidgets('Fuel Map Screen has a title', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: FuelMapScreen(fuelType: 'Petrol')));
    
    // Verify that the title is present
    expect(find.text('Fuel Map'), findsOneWidget);
  });
}
