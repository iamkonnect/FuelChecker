import 'package:flutter/material.dart';

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({super.key});

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  final TextEditingController _issueController = TextEditingController();
  String? selectedIssue;
  String? selectedPetrolStation;

  List<String> commonIssues = [
    'Fuel Station not listed',
    'Fuel Price Difference',
    'Fuel Type Unavailable',
    'App Not Working Properly',
    'Other'
  ];

  List<String> petrolStations = [
    'Station A',
    'Station B',
    'Station C',
    'Station D',
    'Other'
  ];

  @override
  void dispose() {
    _issueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Issue'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Report an Issue',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Please select the type of issue you are facing:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8.0),
              DropdownButton<String>(
                value: selectedIssue,
                hint: const Text('Select an Issue'),
                isExpanded: true,
                items: commonIssues.map((String issue) {
                  return DropdownMenuItem<String>(
                    value: issue,
                    child: Text(issue),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedIssue = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Select Petrol Station:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8.0),
              DropdownButton<String>(
                value: selectedPetrolStation,
                hint: const Text('Select a Petrol Station'),
                isExpanded: true,
                items: petrolStations.map((String station) {
                  return DropdownMenuItem<String>(
                    value: station,
                    child: Text(station),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPetrolStation = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Provide Details:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _issueController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Describe your issue...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.shade400),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.shade700),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
              const SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _submitIssue();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 38.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: const Text(
                    'Submit Issue',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitIssue() {
    final issueDetails = _issueController.text;

    if (selectedIssue != null &&
        selectedPetrolStation != null &&
        issueDetails.isNotEmpty) {
      // Handle the issue submission (e.g., send data to the server)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Thank you for reporting the issue at $selectedPetrolStation!',
          ),
          backgroundColor: Colors.green.shade600,
        ),
      );
      _issueController.clear();
      setState(() {
        selectedIssue = null;
        selectedPetrolStation = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please select an issue, a petrol station, and provide details.',
          ),
          backgroundColor: Colors.red.shade600,
        ),
      );
    }
  }
}
