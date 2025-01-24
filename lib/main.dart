import 'package:flutter/material.dart';
import 'screens/about_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/deactivate_account_screen.dart';
import 'screens/favorite_screen.dart';
import 'screens/fuel_map_screen.dart';
import 'screens/fuel_type_selection_screen.dart';
import 'screens/login_screen.dart';
import 'screens/my_trip_screen.dart';
import 'screens/nearby_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/trends_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/feedback_screen.dart'; // Added import
import 'screens/report_issue_screen.dart'; // Added import
import 'screens/help_screen.dart'; // Added import

void main() {
  runApp(const MyApp()); // Removed 'const' keyword
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Check',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(), // Removed 'const' keyword
        '/login': (context) => const LoginScreen(), // Removed 'const' keyword
        '/fuel_type': (context) => const FuelTypeSelectionScreen(), // Removed 'const' keyword
'/fuel_map': (context) {
  final args = ModalRoute.of(context)!.settings.arguments as String?;
  if (args == null) {
    // Handle the null case, e.g., provide a default value or show an error
    return FuelMapScreen(fuelType: 'defaultFuelType'); // Provide a default value
  }

          return FuelMapScreen(fuelType: args); // Pass fuelType argument
        },

        '/favorites': (context) => const FavoriteScreen(), // Removed 'const' keyword
        '/trends_screen': (context) => TrendsScreen(), // Removed 'const' keyword
        '/my_trip': (context) => const MyTripScreen(), // Removed 'const' keyword
        '/nearby': (context) => const NearbyScreen(), // Removed 'const' keyword
        '/settings': (context) => const SettingsScreen(), // Removed 'const' keyword
        '/about': (context) => const AboutScreen(), // Removed 'const' keyword
        '/feedback': (context) => const FeedbackScreen(), // Removed 'const' keyword
        '/report': (context) => const ReportIssueScreen(), // Removed 'const' keyword
        '/deactivate': (context) => const DeactivateAccountScreen(), // Removed 'const' keyword
        '/analytics': (context) => const AnalyticsScreen(), // Removed 'const' keyword
        '/help': (context) => const HelpScreen(), // Removed 'const' keyword
      },
    );
  }
}
