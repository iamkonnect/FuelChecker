import 'package:flutter/material.dart';

import 'screens/forgot_password_screen.dart'; // Importing the ForgotPasswordScreen
import 'screens/fuel_map_screen.dart'; // Importing the FuelMapScreen
import 'screens/fuel_type_selection_screen.dart'; // Importing the FuelTypeSelectionScreen
import 'screens/login_screen.dart'; // Importing the LoginScreen
import 'screens/navigation_app.dart'; // Importing the NavigationApp
import 'screens/nearby_screen.dart'; // Importing the NearbyScreen
import 'screens/welcome_screen.dart'; // Importing the WelcomeScreen

import 'screens/filter_screen.dart'; // Importing the FilterScreen

void main() { 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(), // Updated to non-const
        '/login': (context) => const LoginScreen(),
        '/fuel_type_selection': (context) => const FuelTypeSelectionScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/navigation': (context) => const NavigationApp(),
        '/filter_screen': (context) => const FilterScreen(), // Adding the filter screen route
        '/nearby': (context) => 
            const FuelCheckerApp(), // Route for NearbyScreen
        '/fuel_map': (context) =>
            const FuelMapScreen(fuelType: 'Blend E5'), // Default fuel type
      },
    );
  }
}
