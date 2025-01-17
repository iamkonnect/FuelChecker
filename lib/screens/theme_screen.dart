import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  _ThemeScreenState createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
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
              isScrollControlled: true,
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
                          groupValue: Provider.of<ThemeProvider>(context).currentTheme == ThemeData.light() ? 'light' : 'dark',
                          onChanged: (value) {
                            Provider.of<ThemeProvider>(context, listen: false).setTheme(value!);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text('Dark Theme'),
                        leading: Radio<String>(
                          value: 'dark',
                          groupValue: Provider.of<ThemeProvider>(context).currentTheme == ThemeData.dark() ? 'dark' : 'light',
                          onChanged: (value) {
                            Provider.of<ThemeProvider>(context, listen: false).setTheme(value!);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Or use the slider to adjust brightness:'),
                      Slider(
                        value: 0.5,
                        min: 0.0,
                        max: 1.0,
                        divisions: 10,
                        activeColor: Colors.red,
                        thumbColor: Colors.red,
                        onChanged: (double value) {
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
