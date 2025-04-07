import 'package:flutter/material.dart';

class SearchBarWithFilter extends StatefulWidget {
  final Function getCoordinates;
  final String from;
  final String to;
  final String searchTerm;
  final ValueChanged<double> onRadiusChanged;
  final ValueChanged<String> onSearchChanged;

  const SearchBarWithFilter({
    Key? key,
    required this.getCoordinates,
    required this.from,
    required this.to,
    required this.searchTerm,
    required this.onRadiusChanged,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  _SearchBarWithFilterState createState() => _SearchBarWithFilterState();
}

class _SearchBarWithFilterState extends State<SearchBarWithFilter> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  String? _selectedFilter;
  double _currentPrice = 0.0;
  double _currentRadius = 5000;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
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
                    controller: _fromController,
                    decoration: _inputDecoration('From', Icons.location_on),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _toController,
                    decoration: _inputDecoration('To', Icons.location_on),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _searchController,
              onChanged: widget.onSearchChanged,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.red),
                  onPressed: _handleSearch,
                ),
                labelText: 'Search gas stations...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('Distance:'),
                    const SizedBox(width: 8),
                    DropdownButton<double>(
                      value: _currentRadius,
                      items: const [
                        DropdownMenuItem(value: 500, child: Text('500m')),
                        DropdownMenuItem(value: 15000, child: Text('15km')),
                        DropdownMenuItem(value: 1000, child: Text('1km')),
                        DropdownMenuItem(value: 2000, child: Text('2km')),
                        DropdownMenuItem(value: 3000, child: Text('3km')),
                        DropdownMenuItem(value: 4000, child: Text('4km')),
                        DropdownMenuItem(value: 5000, child: Text('5km')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _currentRadius = value);
                          widget.onRadiusChanged(value);
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('\$${_currentPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10),
                    const Text('Price Estimation:'),
                  ],
                ),
              ],
            ),
            Slider(
              value: _currentPrice,
              min: 0,
              max: 2,
              divisions: 100,
              label: _currentPrice.toStringAsFixed(2),
              activeColor: Colors.red,
              onChanged: (value) => setState(() => _currentPrice = value),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.red),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }

  void _handleSearch() {
    final from = _fromController.text.trim();
    final to = _toController.text.trim();
    final searchTerm = _searchController.text.trim();

    if (from.isEmpty || to.isEmpty) {
      print('Please provide both "From" and "To" locations.');
      return;
    }

    widget.onSearchChanged(searchTerm);
  }

  List<String> filterResults(
      String from, String to, String searchTerm, String? filter) {
    return [];
  }
}
