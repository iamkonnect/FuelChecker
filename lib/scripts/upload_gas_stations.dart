import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../local_gas_stations.dart';
import '../firebase_options.dart';

Future<void> uploadGasStations() async {
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final firestore = FirebaseFirestore.instance;

  // Use the local gas stations data from Dart file
  for (var station in localGasStations) {
    await firestore.collection('gas_stations').doc(station['id']).set({
      'name': station['name'],
      'town': station['town'],
      'latitude': station['latitude'],
      'longitude': station['longitude'],
      'blendPrice': station['blendPrice'],
      'dieselPrice': station['dieselPrice'],
      'logoAsset': station['logoAsset'],
      'stationIcon': station['stationIcon'],
      'isOpen': station['isOpen'] ?? true, // Default to true if not specified
    });
  }
}
