import 'package:flutter/material.dart';

// Importing the SettingsMenu
import 'screens/forgot_password_screen.dart'; // Importing the ForgotPasswordScreen
import 'screens/fuel_map_screen.dart'; // Importing the FuelMapScreen
import 'screens/fuel_type_selection_screen.dart'; // Importing the FuelTypeSelectionScreen
import 'screens/login_screen.dart'; // Importing the LoginScreen
import 'screens/navigation_app.dart';
import 'screens/nearby_screen.dart'; // Importing the NearbyScreen
import 'screens/welcome_screen.dart'; // Importing the WelcomeScreen
import 'screens/favorite_screen.dart'; // Importing the FavoriteScreen
import 'screens/trends_screen.dart'; // Importing the TrendsScreen
import 'screens/my_trip_button_screen.dart'; // Importing the MyTripButtonScreen
import 'screens/settings_screen.dart'; // Importing the SettingsScreen

import 'screens/filter_screen.dart'; // Importing the FilterScreen
import 'screens/profile_screen.dart'; // Importing the ProfileScreen

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
        primaryColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(), // Set to WelcomeScreen as the initial screen
        '/login': (context) => const LoginScreen(),
        '/fuel_type_selection': (context) => const FuelTypeSelectionScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/navigation': (context) => const NavigationApp(),
        '/filter_screen': (context) => const FilterScreen(), // Adding the filter screen route
        '/nearby': (context) => const NearbyScreen(), // Updated route for NearbyScreen
        '/fuel_map': (context) => const FuelMapScreen(fuelType: 'Blend E5'), // Default fuel type
        '/favorites': (context) => const FavoriteScreen(),
        '/trends_screen': (context) => TrendsScreen(),
        '/my_trips': (context) => const MyTripButtonScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
