import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'providers/favorite_provider.dart'; // Import your FavoriteProvider

// Importing the SettingsMenu
import 'screens/forgot_password_screen.dart'; 
import 'screens/fuel_map_screen.dart'; 
import 'screens/fuel_type_selection_screen.dart'; 
import 'screens/login_screen.dart'; 
import 'screens/navigation_app.dart';
import 'screens/nearby_screen.dart'; 
import 'screens/welcome_screen.dart'; 
import 'screens/favorite_screen.dart'; 
import 'screens/trends_screen.dart'; 
import 'screens/my_trip_button_screen.dart'; 
import 'screens/settings_screen.dart'; 
import 'screens/filter_screen.dart'; 
import 'screens/profile_screen.dart'; 

void main() { 
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoriteProvider()), // Add your provider here
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
      title: 'Fuel Checker',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/fuel_type_selection': (context) => const FuelTypeSelectionScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        '/navigation': (context) => const NavigationApp(),
        '/filter_screen': (context) => const FilterScreen(),
        '/nearby': (context) => const NearbyScreen(),
        '/fuel_map': (context) => const FuelMapScreen(fuelType: 'Blend E5'),
        '/favorites': (context) => const FavoriteScreen(),
        '/trends_screen': (context) => TrendsScreen(),
        '/my_trips': (context) => const MyTripButtonScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
