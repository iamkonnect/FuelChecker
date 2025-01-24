import 'package:flutter/material.dart';
import '../api.dart'; // Import the API functions

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  double fuelUsage = 0;
  double priceFluctuation = 0;
  double favouriteStationsVisits = 0;
  double tripsTargets = 0;

  @override
  void initState() {
    super.initState();
    _fetchAnalyticsData();
  }

  Future<void> _fetchAnalyticsData() async {
    try {
      final data = await fetchAnalytics();
      setState(() {
        fuelUsage = data['fuelUsage'];
        priceFluctuation = data['priceFluctuation'];
        favouriteStationsVisits = data['favouriteStationsVisits'];
        tripsTargets = data['tripsTargets'];
      });
    } catch (e) {
      // Handle error
      print('Error fetching analytics data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Dashboard'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Analytics data will be displayed here.'),
      ),
    );
  }
}
