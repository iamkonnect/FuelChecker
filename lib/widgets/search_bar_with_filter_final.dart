import 'package:flutter/material.dart';

class SearchBarWithFilter extends StatefulWidget {
  @override
  _SearchBarWithFilterState createState() => _SearchBarWithFilterState();
}

class _SearchBarWithFilterState extends State<SearchBarWithFilter> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  double _currentPrice = 250.0;
  String _selectedFilter = '500m';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: fromController,
                  decoration: InputDecoration(
                    hintText: 'From',
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
                    hintText: 'To',
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
                    hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  // Implement search functionality here
                  String from = fromController.text;
                  String to = toController.text;
                  String searchTerm = searchController.text;

                  // Logic to handle the search using from, to, and searchTerm
                  // This is a placeholder for the actual search logic
                  print('Searching from: $from to: $to with term: $searchTerm');
                  // You can call a method to filter the fuel stations based on these values
                },
                color: Colors.blue,
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            value: _selectedFilter,
            onChanged: (String? newValue) {
              setState(() {
                _selectedFilter = newValue!;
              });
            },
            items: <String>['500m', '1km', '2km']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Text('Price Estimation:'),
          Slider(
            value: _currentPrice,
            min: 200,
            max: 300,
            divisions: 100,
            label: _currentPrice.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentPrice = value;
              });
            },
          ),
          Text('\$${_currentPrice.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
