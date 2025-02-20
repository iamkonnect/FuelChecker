import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
  SearchBarWithFilterState createState() => SearchBarWithFilterState();
}

class SearchBarWithFilterState extends State<SearchBarWithFilter> {
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
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).toInt()),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
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
                    labelText: 'From',
                    prefixIcon: const Icon(Icons.location_on, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: toController,
                  decoration: InputDecoration(
                    labelText: 'To',
                    prefixIcon: const Icon(Icons.location_on, color: Colors.red),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search, color: Colors.red),
                      onPressed: () {
                        String from = fromController.text.trim();
                        String to = toController.text.trim();
                        String searchTerm = searchController.text.trim();

                        if (from.isEmpty || to.isEmpty) {
                          Logger().w('Please provide both "From" and "To" locations.');
                          return;
                        }

                        List<String> results = filterResults(
                            from, to, searchTerm, _selectedFilter);
                        Logger().i('Searching from: $from to: $to with term: $searchTerm');
                        Logger().d('Results: $results');
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Detour',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.tune, color: Colors.red),
                    onSelected: (String selectedValue) {
                      setState(() {
                        _selectedFilter = selectedValue;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return <String>['500m', '1km', '2km', '5km', '10km']
                          .map((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.black),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '\$${_currentPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Price Estimation:',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
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
    if (from.isEmpty || to.isEmpty) {
      Logger().w('Please provide both "From" and "To" locations.');
      return [];
    }
    
    List<String> allResults = ['Result 1', 'Result 2', 'Result 3'];
    List<String> filteredResults = allResults.where((result) {
      return result.contains(searchTerm) && 
             result.contains(filter ?? '');
    }).toList();
    
    return filteredResults;
  }
}
