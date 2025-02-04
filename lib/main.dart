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
import 'screens/profile_screen.dart'; // Added import for ProfileScreen
import 'screens/verification_screen.dart'; // Importing the VerificationScreen

import 'package:provider/provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/theme_provider.dart'; // Import ThemeProvider

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoriteProvider()..populateDummyFavorites()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()), // Add ThemeProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Check',
      theme: Provider.of<ThemeProvider>(context).currentTheme, // Apply current theme
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/fuel_type': (context) => const FuelTypeSelectionScreen(),
        '/fuel_map': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String?;
          if (args == null) {
            return FuelMapScreen(fuelType: 'defaultFuelType');
          }
          return FuelMapScreen(fuelType: args);
        },
        '/favorites': (context) => const FavoriteScreen(),
        '/trends_screen': (context) => TrendsScreen(),
        '/my_trip': (context) => const MyTripScreen(),
        '/nearby': (context) => const NearbyScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/about': (context) => const AboutScreen(),
        '/feedback': (context) => const FeedbackScreen(),
        '/report': (context) => const ReportIssueScreen(),
        '/deactivate': (context) => const DeactivateAccountScreen(),
        '/analytics': (context) => const AnalyticsScreen(),
        '/help': (context) => const HelpScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/verification': (context) => const VerificationScreen(isVerified: false), // Added route for VerificationScreen
      },
    );
  }
}
