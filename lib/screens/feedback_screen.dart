import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FeedbackScreen(),
    );
  }
}

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  bool? _isLiked;
  final TextEditingController _commentsController = TextEditingController();
  bool _isSubmitting = false;

  void _submitFeedback() {
    if (_commentsController.text.isNotEmpty) {
      setState(() {
        _isSubmitting = true;
      });
      // Simulate a network call
      Future.delayed(const Duration(seconds: 2), () {
        // Handle feedback submission logic here
        setState(() {
          _isSubmitting = false;
        });
        // Optionally clear the text field
        _commentsController.clear();
        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback submitted successfully!')),
        );
      });
    } else {
      // Show an error message if comments are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your comments.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Do you like Fuel Check?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLiked = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 30.0,
                    ),
                    backgroundColor: _isLiked == true ? Colors.black : Colors.red,
                  ),
                  child: const Icon(
                    Icons.thumb_up,
                    size: 30.0,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLiked = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 30.0,
                    ),
                    backgroundColor: _isLiked == false ? Colors.black : Colors.red,
                  ),
                  child: const Icon(
                    Icons.thumb_down,
                    size: 30.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Share some comments about your experience with the app ',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _commentsController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Your comments here...',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submitFeedback,
              child: _isSubmitting
                  ? const CircularProgressIndicator()
                  : const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
