import 'package:flutter/material.dart';

class FuelSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset('./assets/group-17.svg'),
          onPressed: () {
            // Navigate back to the fuel map page
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset('./assets/group-18.svg'),
            onPressed: () {
              // Navigate to the update detail page
            },
          ),
        ],
        title: Text(
          '88',
          style: TextStyle(
            fontFamily: 'Agency FB',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Color(0xFF0B1223),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                'Find a low cost',
                style: TextStyle(
                  fontFamily: 'Agency FB',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Color(0xFF0B1223).withOpacity(0.45),
                ),
              ),
              Text(
                'Fuel Nearby',
                style: TextStyle(
                  fontFamily: 'Agency FB',
                  fontWeight: FontWeight.w700,
                  fontSize: 39,
                  color: Color(0xFFDF2626),
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Puma Petroleum',
                        hintStyle: TextStyle(
                          fontFamily: 'Agency FB',
                          fontWeight: FontWeight.w700,
                          fontSize: 21,
                          color: Color(0xFF0B1223),
                        ),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Image.asset('./assets/iconly-light-filter.svg'),
                    onPressed: () {
                      // Filter action
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Search results',
                style: TextStyle(
                  fontFamily: 'Agency FB',
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                  color: Color(0xFF0B1223).withOpacity(0.45),
                ),
              ),
              SizedBox(height: 16),
              _buildFuelStationCard(context, '3 km away', './assets/img-20240207-wa-0018-1.svg', '\$1.39', '\$1.59'),
              _buildFuelStationCard(context, 'Closed', './assets/img-20240207-wa-0018-1-2.svg', '\$1.36', '\$1.50'),
              _buildFuelStationCard(context, 'Closed', './assets/img-20240207-wa-0018-1-3.svg', '\$1.27', '\$1.40'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFuelStationCard(BuildContext context, String status, String imgPath, String price1, String price2) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(imgPath, width: 38, height: 36),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Puma Petroleum',
                    style: TextStyle(
                      fontFamily: 'Agency FB',
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Color(0xFF0B1223),
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      fontFamily: 'Agency FB',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: status != 'Closed' ? Color(0xFFDF2626) : Color(0xFF0B1223).withOpacity(0.45),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Blend E5',
                        style: TextStyle(
                          fontFamily: 'Agency FB',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color(0xFF0B1223).withOpacity(0.45),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Diesel',
                        style: TextStyle(
                          fontFamily: 'Agency FB',
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Color(0xFF0B1223).withOpacity(0.45),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        price1,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xFF0B1223).withOpacity(0.45),
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        price2,
                        style: TextStyle(
                          fontFamily: 'Agency FB',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color(0xFF0B1223).withOpacity(0.45),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Image.asset('./assets/coco-line-send.svg'),
              onPressed: () {
                // Open direction in map
              },
            ),
          ],
        ),
      ),
    );
  }
}
