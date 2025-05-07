import 'package:firebase_core/firebase_core.dart'; // Ensure this import exists
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
import 'services/favorites_service.dart';
import 'services/nearby_service.dart';
import 'providers/favorite_provider.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Firebase initialized successfully!");
  // Initialize Firebase with your configuration
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAyySS4qUvBiSadoplbTQT6g-vi3OElxWM",
        authDomain: "bahati-4911e.firebaseapp.com",
        projectId: "bahati-4911e",
        storageBucket: "bahati-4911e.firebasestorage.app",
        messagingSenderId: "588077245698",
        appId: "1:588077245698:web:0122f07e52f59e65a70e1b",
        measurementId: "G-ER707HTEVD"),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesService()),
        ChangeNotifierProvider(
          create: (context) => NearbyService(),
        ),
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
        '/trends_screen': (context) => const TrendsScreen(),
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
