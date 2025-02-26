import 'package:flutter/material.dart';

class GasStationMarker extends StatelessWidget {
  final String logoAsset;
  final double dieselPrice;

  const GasStationMarker({
    Key? key,
    required this.logoAsset,
    required this.dieselPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(logoAsset),
            ),
            const SizedBox(height: 4),
            Text(
              'Diesel: \$${dieselPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class GasStationMarker extends StatelessWidget {
//   final String logoAsset;
//   final double dieselPrice;

//   const GasStationMarker({
//     Key? key,
//     required this.logoAsset,
//     required this.dieselPrice,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Logo
//           logoAsset.startsWith('http')
//               ? Image.network(logoAsset, width: 40, height: 40)
//               : Image.asset(logoAsset, width: 40, height: 40),
//           const SizedBox(height: 4),
//           // Diesel Price
//           Text(
//             'Diesel: \$${dieselPrice.toStringAsFixed(2)}',
//             style: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
