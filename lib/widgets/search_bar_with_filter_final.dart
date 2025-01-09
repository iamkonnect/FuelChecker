import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart'; // Import LatLng type
import '../screens/fuel_map_screen.dart'; // Import FuelMapScreen to access its state

class SearchBarWithFilter extends StatefulWidget {
  @override
  _SearchBarWithFilterState createState() => _SearchBarWithFilterState();
}

class _SearchBarWithFilterState extends State<SearchBarWithFilter> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  double _currentPrice = 1.0; // Updated to a value within the slider range
  String _selectedFilter = '500m';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white, // Set background to white
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: fromController,
                    decoration: InputDecoration(
                      labelText: 'From',
                      prefixIcon: Icon(Icons.location_on, color: Colors.red), // Change icon color to red
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: toController,
                    decoration: InputDecoration(
                      labelText: 'To',
                      prefixIcon: Icon(Icons.location_on, color: Colors.red), // Change icon color to red
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search (optional)...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search, color: Colors.red), // Change icon color to red
                  onPressed: () async {
                    String from = fromController.text;
                    String to = toController.text;
                    String searchTerm = searchController.text;

                    // Retrieve coordinates for From and To locations
                    var fromCoordinates = await getCoordinates(from);
                    var toCoordinates = await getCoordinates(to);

                    // Call method in FuelMapScreen to update markers and directions
                    if (fromCoordinates != null && toCoordinates != null) {
                      FuelMapScreenState? fuelMapScreenState = context.findAncestorStateOfType<FuelMapScreenState>();
                      fuelMapScreenState?.updateMarkers(fromCoordinates, toCoordinates);
                      fuelMapScreenState?.calculateDirections(fromCoordinates, toCoordinates); // Call to calculate directions
                    }
                    print('Searching from: $from to: $to with term: $searchTerm');
                  },
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Detour', style: TextStyle(color: Colors.black, fontSize: 16)),
                    Container(
                      width: 100, // Set a fixed width for the dropdown
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Padding for the dropdown
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromARGB(255, 132, 133, 134)), // Updated border color
                        borderRadius: BorderRadius.circular(10), // Rounded corners
                      ),
                      child: DropdownButton<String>(
                        value: _selectedFilter,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedFilter = newValue!;
                          });
                        },
                        items: <String>['500m', '1km', '2km', '5km', '10km' ]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        dropdownColor: Colors.white,
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
                  children: [
                    Text('\$${_currentPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                    SizedBox(width: 10), // Space between the price and the label
                    Text('Price Estimation:', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Slider(
              value: _currentPrice,
              min: 0,
              max: 2,
              divisions: 100,
              label: _currentPrice.round().toString(),
              activeColor: Colors.red, // Set the slider color to red
              onChanged: (double value) {
                setState(() {
                  _currentPrice = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<LatLng?> getCoordinates(String location) async {
    // Placeholder for the logic to get coordinates based on the location name
    // This could involve calling a geocoding API or service
    // For now, return null or a default value
    return null; // Replace with actual implementation
  }

  // Add this method to handle filtering logic
  List<String> filterResults(String from, String to, String searchTerm, String selectedFilter) {
      // Example data source for filtering
      List<String> allResults = [
          'Location A',
          'Location B',
          'Location C',
          'Location D',
          'Location E',
      ];

      // Filter based on the input values
      return allResults.where((location) {
          bool matchesFrom = from.isEmpty || location.toLowerCase().contains(from.toLowerCase());
          bool matchesTo = to.isEmpty || location.toLowerCase().contains(to.toLowerCase());
          bool matchesSearchTerm = searchTerm.isEmpty || location.toLowerCase().contains(searchTerm.toLowerCase());
          bool matchesFilter = true; // Implement filter logic based on selectedFilter if needed

          return matchesFrom && matchesTo && matchesSearchTerm && matchesFilter;
      }).toList();
  }
}
