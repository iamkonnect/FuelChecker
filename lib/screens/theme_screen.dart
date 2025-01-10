import 'package:flutter/material.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  double _sliderValue = 0.5; // Default value for slider

  // If you need to implement the theme selection logic
  void _selectTheme(String selectedTheme) {
    // Implement your theme selection logic here
    print("Selected theme: $selectedTheme");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Theme'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled:
                  true, // Allows the bottom sheet to be half-screen
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Theme',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Light/Dark Theme Selection using Radio Buttons
                      ListTile(
                        title: const Text('Light Theme'),
                        leading: Radio<String>(
                          value: 'light',
                          groupValue:
                              'theme', // Replace with actual selected theme state
                          onChanged: (value) {
                            _selectTheme(value!);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Dark Theme'),
                        leading: Radio<String>(
                          value: 'dark',
                          groupValue:
                              'theme', // Replace with actual selected theme state
                          onChanged: (value) {
                            _selectTheme(value!);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Or use the slider to adjust brightness:'),
                      Slider(
                        value: _sliderValue,
                        min: 0.0,
                        max: 1.0,
                        divisions: 10,
                        activeColor: Colors
                            .red, // Set the color of the active part of the slider
                        thumbColor:
                            Colors.red, // Set the color of the slider thumb
                        onChanged: (double value) {
                          setState(() {
                            _sliderValue = value;
                          });
                          // Implement your slider behavior to adjust theme brightness or other logic
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Text('Change Theme'),
        ),
      ),
    );
  }
}
