import 'package:flutter/material.dart';

void _showGasStationBottomSheet(GasStation station) {
  setState(() {
    _isLocationDetailsVisible = true;
  });

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  station.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 24),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _isLocationDetailsVisible = false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Image.asset(
              station.logoAsset,
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 10),
            Text(
              'Blend Price: \$${station.blendPrice}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Diesel Price: \$${station.dieselPrice}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Status: ${_isGasStationOpen() ? "Open" : "Closed"}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            IconButton(
              icon: const Icon(Icons.directions, size: 32),
              onPressed: () {
                _drawPathLine(station);
              },
            ),
          ],
        ),
      );
    },
  );
}

bool _isGasStationOpen() {
  // Add logic to determine if the gas station is open or closed
  // For now, we'll assume it's always open
  return true;
}
