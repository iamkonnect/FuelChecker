import 'package:flutter/material.dart';
import 'package:fuel_checker/FuelMap.dart'; // Ensure FuelMapPage is defined in this file

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FeedbackPage(), // Make this const
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key}); // Keep const here

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController feedbackController = TextEditingController();
  int? rating; // To store the star rating

void submitFeedback(BuildContext context) {
  final feedback = feedbackController.text;

  if (feedback.isEmpty || rating == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please provide feedback and a rating.'),
      ),
    );
    return;
  }

  final sun = 'support@fuelcheckerzw.com';

  // Here you can implement email sending logic or any other feedback handling logic.
  // For example, you could call an API to send the feedback to the email address.

  // Example: sendFeedbackToEmail(email, feedback, rating);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Feedback submitted'),
    ),
  );

  // Navigate back to the Fuel Map
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => const FuelMapPage()), // Ensure FuelMapPage is defined
  );
}

  Widget buildStar(int index) {
    return IconButton(
      icon: Icon(
        index <= (rating ?? 0) ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 40,
      ),
      onPressed: () {
        setState(() {
          rating = index; // Update the rating based on the star clicked
        });
      },
    );
  }

  @override
  void dispose() {
    feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/arrow-left.svg'), // Ensure this path is correct
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Feedback',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Text(
              'Rate your experience with Fuel Check:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => buildStar(index + 1)),
            ),
            SizedBox(height: 24),
            Text(
              'Share some comments about your experience with the app.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please do not include any personal details such as phone numbers, email addresses or account details',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: feedbackController,
              decoration: InputDecoration(
                border: OutlineInput;