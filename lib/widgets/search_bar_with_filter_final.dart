import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package
import '../screens/fuel_map_screen.dart'; // Import FuelMapScreen

class SearchBarWithFilter extends StatefulWidget {
  final Function getCoordinates;
  final String from;
  final String to;
  final String searchTerm;

  const SearchBarWithFilter({
    Key? key,
    required this.getCoordinates,
    required this.from,
    required this.to,
    required this.searchTerm,
  }) : super(key: key);

  @override
  _SearchBarWithFilterState createState() => _SearchBarWithFilterState();
}

class _SearchBarWithFilterState extends State<SearchBarWithFilter> {
  String from = ''; // Initialize from variable
  String to = ''; // Initialize to variable
  String searchTerm = ''; // Initialize search term variable
  String? _selectedFilter; // Initialize selected filter variable
  double _currentPrice = 0.0; // Initialize current price variable

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              from = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'From',
            border: OutlineInputBorder(),
          ),
        ),
        TextField(
          onChanged: (value) {
            setState(() {
              to = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'To',
            border: OutlineInputBorder(),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            var fromCoordinates = await widget.getCoordinates(from);
            var toCoordinates = await widget.getCoordinates(to);

            // Call method in FuelMapScreen to update markers and directions
            if (fromCoordinates != null && toCoordinates != null) {
              FuelMapScreenState? fuelMapScreenState = context.findAncestorStateOfType<FuelMapScreenState>();
              fuelMapScreenState?.updateMarkers(fromCoordinates, toCoordinates);
              fuelMapScreenState?.calculateDirections(fromCoordinates, toCoordinates); // Call to calculate directions
            }
            print('Searching from: $from to: $to with term: $searchTerm');
          },
          child: Text('Search'),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<String>(
              value: _selectedFilter,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedFilter = newValue!;
                });
              },
              items: <String>['500m', '1km', '2km', '5km', '10km']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              dropdownColor: Colors.white,
              isExpanded: true,
            ),
            Text('\$${_currentPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
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
    );
  }
}