// Hiding MyApp from feedback_page.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart';
import '../lib/screens/welcome_screen.dart';



void main() {
  testWidgets('MyApp widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify the initial route is WelcomeScreen
    expect(find.byType(WelcomeScreen), findsOneWidget);
  });

}
