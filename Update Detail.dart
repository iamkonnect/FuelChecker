import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UpdateDetailsScreen(),
    );
  }
}

class UpdateDetailsScreen extends StatelessWidget {
  final List<String> genders = ['Male', 'Female'];
  final List<String> regions = ['Region 1', 'Region 2', 'Region 3'];
  final List<String> districts = ['District 1', 'District 2', 'District 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Color(0xFFDF2626),
        elevation: 0,
        toolbarHeight: 91,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Update Details',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                )),
            SizedBox(height: 4),
            Text('Fill in your details',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white,
                )),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Implement navigation to the main dashboard here
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Center(
          child: Column(
            children: [
              buildTextField('Enter phone number'),
              buildTextField('Enter Street name'),
              buildDropdown('Select Region', regions),
              buildDropdown('Select District', districts),
              buildReadOnlyField('Date of Birth: 01/01/1990'), // example DOB
              buildDropdown('Select Gender', genders),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Implement update logic here
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFDF2626),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 140, vertical: 14),
                ),
                child: Text(
                  'Update',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hintText) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Color(0xFF6F767E),
          ),
        ),
      ),
    );
  }

  Widget buildReadOnlyField(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Color(0xFF6F767E),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdown(String hint, List<String> items) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: SizedBox(),
        hint: Text(
          hint,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: Color(0xFF6F767E),
          ),
        ),
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF6F767E),
                )),
          );
        }).toList(),
        onChanged: (_) {
          // Handle change
        },
      ),
    );
  }
}
