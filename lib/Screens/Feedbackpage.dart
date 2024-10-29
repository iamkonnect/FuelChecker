import 'package:flutter/material.dart';
import 'package:fuel_checker/Screens/FuelMap.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedbackPage(),
    );
  }
}

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key}); // Add const here

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController feedbackController = TextEditingController();
  int? rating; // To store the star rating

  void submitFeedback(BuildContext context) {
    final feedback = feedbackController.text;
    final email = 'support@fuelcheckerzw.com';
    
    // Here you can implement email sending logic or any other feedback handling logic.
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Feedback submitted'),
      ),
    );

    // Navigate back to the Fuel Map
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const FuelMapPage()), // Add const here
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
          icon: Image.asset('./assets/arrow-left.svg'),
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
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(16.0),
                hintText: 'Enter your comments here',
              ),
              maxLines: 4,
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () => submitFeedback(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFdf2626),
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
   