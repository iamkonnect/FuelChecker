// firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/fuel_gas_station.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<GasStation>> getGasStations() {
    return _firestore
        .collection('gasStations')
        .snapshots()
        .handleError((error) {
      print("Firestore error: $error");
    }).map((snapshot) =>
            snapshot.docs.map((doc) => GasStation.fromFirestore(doc)).toList());
  }

  Future<void> addGasStation(GasStation station) async {
    await _firestore.collection('gasStations').doc(station.id).set({
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
  }
}
