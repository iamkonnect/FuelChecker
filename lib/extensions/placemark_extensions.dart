import 'package:geocoding/geocoding.dart';

extension PlacemarkDebugging on Placemark {
  /// Converts a Placemark object to a JSON map for debugging purposes.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'street': street,
      'locality': locality,
      'subLocality': subLocality,
      'administrativeArea': administrativeArea,
      'subAdministrativeArea': subAdministrativeArea,
      'postalCode': postalCode,
      'country': country,
      'isoCountryCode': isoCountryCode,
    };
  }
}
