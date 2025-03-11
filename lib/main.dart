import './services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'screens/about_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/deactivate_account_screen.dart';
import 'screens/favorite_screen.dart';
import 'screens/fuel_map_screen.dart';
import 'screens/fuel_type_selection_screen.dart';
import 'screens/login_screen.dart';
import 'screens/nearby_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/trends_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/feedback_screen.dart';
import 'screens/report_issue_screen.dart';
import 'screens/help_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/verification_screen.dart';
import 'package:provider/provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/theme_provider.dart';
import './scripts/migration_script.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Firebase initialized successfully!");
  // Initialize Firebase
  await FirebaseService.initialize(); // Use service class
// Run migration (remove after first run)
  await uploadLocalStations();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavoriteProvider()..populateDummyFavorites(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
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
      theme: Provider.of<ThemeProvider>(context).currentTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/fuel_type': (context) => const FuelTypeSelectionScreen(),
        '/fuel_map': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String?;
          return FuelMapScreen(fuelType: args ?? 'defaultFuelType');
        },
        '/favorites': (context) => const FavoriteScreen(),
        '/trends_screen': (context) => TrendsScreen(),
        '/nearby': (context) => const NearbyScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/about': (context) => const AboutScreen(),
        '/feedback': (context) => const FeedbackScreen(),
        '/report': (context) => const ReportIssueScreen(),
        '/deactivate': (context) => const DeactivateAccountScreen(),
        '/analytics': (context) => const AnalyticsScreen(),
        '/help': (context) => const HelpScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/verification': (context) =>
            const VerificationScreen(isVerified: false),
      },
    );
  }
}
