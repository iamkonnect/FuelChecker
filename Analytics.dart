import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                _buildTargetSection(),
                SizedBox(height: 16),
                _buildInfoCardsRow(),
                SizedBox(height: 16),
                _buildExpenseHistory(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildTargetSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircularProgressIndicator(
            title: 'Favourite Station Visits',
            percentage: 58,
            color: Colors.red,
          ),
          _buildCircularProgressIndicator(
            title: 'Trips Target',
            percentage: 75,
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgressIndicator(
      {required String title, required int percentage, required Color color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              value: percentage / 100,
              strokeWidth: 6,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation(color),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF171725),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF92929D),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCardsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoCard(
          amount: '\$26',
          title: 'Fuel Usage',
          percentage: '+2.5%',
          iconPath: 'assets/group-7-2.svg',
        ),
        _buildInfoCard(
          amount: '\$66',
          title: 'Price Fluctuation',
          percentage: '+2.5%',
          iconPath: 'assets/group-7.svg',
        ),
      ],
    );
  }

  Widget _buildInfoCard(
      {required String amount,
      required String title,
      required String percentage,
      required String iconPath}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_gas_station, size: 30),
                SizedBox(width: 8),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF171725),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF696974),
              ),
            ),
            SizedBox(height: 10),
            Text(
              percentage,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFFEC751F),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseHistory() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fuel Expense History',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF171725),
            ),
          ),
          SizedBox(height: 16),
          _buildChartSelector(),
          SizedBox(height: 16),
          Image.asset('assets/shape-13.svg'), // Placeholder for graph image
        ],
      ),
    );
  }

  Widget _buildChartSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _selectorText('Daily', false),
        _selectorText('Weekly', false),
        _selectorText('Monthly', true),
        _selectorText('Yearly', false),
      ],
    );
  }

  Widget _selectorText(String text, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: isSelected ? Colors.white : Color(0xFF696974),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.trending_up),
          label: 'Trends',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_car),
          label: 'My Trip',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.place),
          label: 'Nearby',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favourite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true,
    );
  }
}
