import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedbackPage(),
    );
  }
}

class FeedbackPage extends StatelessWidget {
  final TextEditingController feedbackController = TextEditingController();

  void submitFeedback(BuildContext context) {
    final feedback = feedbackController.text;
    final email = 'support@fuelcheckerzw.com';
    // Send email function can be called here.
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Feedback submitted'),
      ),
    );

    // Navigate back to the Fuel Map
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => FuelMapPage()),
    );
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
              'Do you like Fuel Check?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Image.asset('./assets/group-768.svg'),
                  iconSize: 95,
                  onPressed: () {
                    // Handle thumb up action
                  },
                ),
                IconButton(
                  icon: Image.asset('./assets/group-769.svg'),
                  iconSize: 95,
                  onPressed: () {
                    // Handle thumb down action
                  },
                ),
              ],
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
    );
  }
}

class FuelMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuel Map'),
      ),
      body: Center(
        child: Text('Fuel Map Content Here'),
      ),
    );
  }
}
