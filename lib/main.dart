import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text(
          'Welcome to the FuelChecker First Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

//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 TOKEN
// class MyFirstScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('First Screen'),
//       ),
//       body: Center(
//         child: Text(
//           'Hello, Flutter!',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }
