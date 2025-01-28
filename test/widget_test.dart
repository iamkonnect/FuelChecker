import 'package:flutter_test/flutter_test.dart'; // Added import for testing
import 'package:fuel_check/main.dart'; // Corrected path to match the actual app's main file path

void main() {
  testWidgets('AnalyticsScreen has a title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Analytics Dashboard'), findsOneWidget);
  });
}
