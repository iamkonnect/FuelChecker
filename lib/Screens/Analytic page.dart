import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnalyticsScreen(),
    );
  }
}

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 44), // iOS Status Bar height
            Dashboard(),
            SizedBox(height: 16),
            Metrics(),
            SizedBox(height: 16),
            ExpenseHistory(),
            SizedBox(height: 16),
            BottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
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
          children: [
            DashboardCard(
              percentage: '58%',
              label: 'Favourite Station Visits',
              icon: './assets/ic-goal.svg',
            ),
            DashboardCard(
              percentage: '75%',
              label: 'Trips Target',
              icon: './assets/ic-goal-copy.svg',
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String percentage;
  final String label;
  final String icon;

  DashboardCard({required this.percentage, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(icon, width: 64, height: 56),
            Text(
              percentage,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Color(0xFF92929D)),
        ),
      ],
    );
  }
}

class Metrics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MetricCard(
          amount: '\$26',
          title: 'Fuel Usage',
          change: '+2.5%',
          icon: './assets/group-7-2.svg',
        ),
        MetricCard(
          amount: '\$66',
          title: 'Price Fluctuation',
          change: '+2.5%',
          icon: './assets/group-7.svg',
        ),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  final String amount;
  final String title;
  final String change;
  final String icon;

  MetricCard({required this.amount, required this.title, required this.change, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(icon, width: 40, height: 40),
            SizedBox(height: 8),
            Text(
              amount,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Color(0xFF696974)),
            ),
            SizedBox(height: 2),
            Text(
              change,
              style: TextStyle(fontSize: 12, color: Color(0xFFEC751F), fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Fuel Expense History',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FilterItem(label: 'Daily', isActive: false),
                  FilterItem(label: 'Weekly', isActive: false),
                  FilterItem(label: 'Monthly', isActive: true),
                  FilterItem(label: 'Yearly', isActive: false),
                ],
              ),
            ),
            // Graph Placeholder
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  color: Colors.transparent,
                  child: Placeholder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  final String label;
  final bool isActive;

  FilterItem({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: isActive ? Colors.white : Color(0xFF696974),
      ),
    );
  }
}

class BottomNavigationBar extends StatelessWidget {
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
        children: [
          NavigationBarItem(icon: './assets/image-2.svg', label: 'Trends'),
          NavigationBarItem(icon: './assets/image-10.svg', label: 'My Trip'),
          NavigationBarItem(icon: './assets/image-6.svg', label: 'Nearby'),
          NavigationBarItem(icon: './assets/image-8.svg', label: 'Favourite'),
          NavigationBarItem(icon: './assets/image-4.svg', label: 'Settings'),
        ],
      ),
    );
  }
}

class NavigationBarItem extends StatelessWidget {
  final String icon;
  final String label;

  NavigationBarItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon, width: 25, height: 25),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }
}
