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
  String from = '';
  String to = '';
  String searchTerm = '';
  String? _selectedFilter;
  double _currentPrice = 0.0;

  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: fromController,
                  decoration: InputDecoration(
                    labelText: 'From',
                    prefixIcon: Icon(Icons.location_on, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: toController,
                  decoration: InputDecoration(
                    labelText: 'To',
                    prefixIcon: Icon(Icons.location_on, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search, color: Colors.red),
                      onPressed: () {
                        String from = fromController.text;
                        String to = toController.text;
                        String searchTerm = searchController.text;

                        List<String> results =
                            filterResults(from, to, searchTerm, _selectedFilter);
                        print(
                            'Searching from: $from to: $to with term: $searchTerm');

                        List<String> testResults =
                            filterResults('Location A', 'Location B', '', _selectedFilter);
                        print('Test Filtered results: $testResults');
                      },
                    ),
                    labelText: 'Search (optional)...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Detour',
                      style: TextStyle(color: Colors.black, fontSize: 16)),
                  Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 132, 133, 134)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
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
                  ),
                ],
              ),
              Row(
                children: [
                  Text('\$${_currentPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(width: 10),
                  Text('Price Estimation:',
                      style: TextStyle(color: Colors.black)),
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
            activeColor: Colors.red,
            onChanged: (double value) {
              setState(() {
                _currentPrice = value;
              });
            },
          ),
        ],
      ),
    );
  }

  List<String> filterResults(
      String from, String to, String searchTerm, String? filter) {
    // Replace this with your filtering logic
    return [];
  }
}
