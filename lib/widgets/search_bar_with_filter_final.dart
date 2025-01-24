import 'package:flutter/material.dart';

class SearchBarWithFilter extends StatefulWidget {
  final Function getCoordinates;
  final String from;
  final String to;
  final String searchTerm;

  const SearchBarWithFilter({
    super.key,
    required this.getCoordinates,
    required this.from,
    required this.to,
    required this.searchTerm,
  });

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
            offset: const Offset(0, 4), // Shadow position
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
                      prefixIcon: SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(Icons.location_on), // Google icon font
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: toController,
                    decoration: InputDecoration(
                      prefixIcon: SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(Icons.location_on), // Google icon font
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      hintText: 'Search (optional)...',
                      prefixIcon: const Icon(Icons.search, color: Colors.red),
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
                const Text('Detour', style: TextStyle(color: Colors.black, fontSize: 16)),
                Text('\$${_currentPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                const Text('Price Estimation:', style: TextStyle(color: Colors.black)),
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
      ),
    );
  }

  List<String> filterResults(String from, String to, String searchTerm, String? filter) {
    // Replace this with your filtering logic
    return [];
  }
}
