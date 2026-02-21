// scripts/migration_script.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../local_gas_stations.dart'; // Update with your actual path
import '../models/fuel_gas_station.dart'; // Update path
import '../firebase_options.dart'; // From project root

Future<void> main() async {
  // Remove WidgetsFlutterBinding
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await uploadLocalStations();
  print('✅ Migration completed!');
}

Future<void> uploadLocalStations() async {
  final firestore = FirebaseFirestore.instance;

  for (var stationData in localGasStations) {
    // Handle missing isOpen field in local data
    final station = GasStation.fromMap(
      stationData['id'].toString(),
      {
        ...stationData,
        'isOpen': true, // Add default value for migration
      },
    );

    await firestore.collection('gasStations').doc(station.id).set({
      'name': station.name,
      'town': station.town,
      'latitude': station.latitude,
      'longitude': station.longitude,
      'blendPrice': station.blendPrice,
      'dieselPrice': station.dieselPrice,
      'logoAsset': station.logoAsset,
      'stationIcon': station.stationIcon,
      'isOpen': station.isOpen,
    });
    print('Uploaded: ${station.name}');
  }
}
