// Hiding MyApp from feedback_page.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:FuelCheckZW/main.dart'; // Importing main.dart

void main() {
  testWidgets('AnalyticsScreen has a title', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    expect(find.text('Analytics Dashboard'), findsOneWidget);
  });
}
