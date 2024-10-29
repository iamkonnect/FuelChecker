import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuel Checker',
      home: const AnalyticsScreen(),
    );
  }
}

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 44), // iOS Status Bar height
            Dashboard(),
            SizedBox(height: 16),
            Metrics(),
            SizedBox(height: 16),
            ExpenseHistory(),
            SizedBox(height: 16),
            CustomBottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            DashboardCard(
              percentage: '58%',
              label: 'Favourite Station Visits',
              icon: 'assets/ic-goal.svg',
            ),
            DashboardCard(
              percentage: '75%',
              label: 'Trips Target',
              icon: 'assets/ic-goal-copy.svg',
            ),
          ],
        ),
      ),
    );
  }
}

class Metrics extends StatelessWidget {
  const Metrics({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.blue,
      child: const Center(child: Text('Metrics')),
    );
  }
}

class ExpenseHistory extends StatelessWidget {
  const ExpenseHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.green,
      child: const Center(child: Text('Expense History')),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          NavigationBarItem(icon: 'assets/image-2.svg', label: 'Trends'),
          NavigationBarItem(icon: 'assets/image-10.svg', label: 'My Trip'),
          NavigationBarItem(icon: 'assets/image-6.svg', label: 'Nearby'),
          NavigationBarItem(icon: 'assets/image-8.svg', label: 'Favourite'),
          NavigationBarItem(icon: 'assets/image-4.svg', label: 'Settings'),
        ],
      ),
    );
  }
}

class NavigationBarItem extends StatelessWidget {
  final String icon;
  final String label;

  const NavigationBarItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Replace with an actual SVG widget
        Icon(Icons.circle), // Placeholder for the icon
        Text(label),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String percentage;
  final String label;
  final String icon;

  const DashboardCard({
    super.key,
    required this.percentage,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Replace with an actual SVG widget
        Icon(Icons.circle), // Placeholder for the icon
        Text(percentage),
        Text(label),
      ],
    );
  }
}