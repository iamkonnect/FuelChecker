import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/fuel_type_selection_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/navigation_app.dart';
import 'screens/fuel_checker_app.dart';
import 'screens/fuel_map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/fuel_type_selection': (context) => const FuelTypeSelectionScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/navigation': (context) => const NavigationApp(),
        '/nearby': (context) => const FuelCheckerApp(), // Route for NearbyScreen
        '/fuel_map': (context) => const FuelMapScreen(fuelType: 'Blend E5'), // Default fuel type
      },
    );
  }
}
