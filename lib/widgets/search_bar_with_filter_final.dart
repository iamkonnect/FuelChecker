String from = ''; // Initialize from variable
String to = ''; // Initialize to variable
String searchTerm = ''; // Initialize search term variable

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
        SizedBox(height = 20),
        Row(
          mainAxisAlignment = MainAxisAlignment.spaceBetween,
          children = [
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
        SizedBox(height = 20),
        Slider(
          value = _currentPrice,
          min = 0,
          max = 2,
          divisions = 100,
          label = _currentPrice.round().toString(),
          activeColor = Colors.red, // Set the slider color to red
          onChanged = (double value) {
            setState(() {
              _currentPrice = value;
            });
          },
        ),
      ],
    ),
  ),
);