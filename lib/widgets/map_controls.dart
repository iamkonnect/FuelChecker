import 'package:flutter/material.dart';
import '../controllers/map_controller.dart';

class MapControls extends StatelessWidget {
  final MapController controller;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onLocateUser;

  const MapControls({
    Key? key,
    required this.controller,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onLocateUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16.0,
      bottom: 16.0,
      child: Column(
        children: [
          FloatingActionButton(
            mini: true,
            heroTag: 'zoomIn',
            onPressed: onZoomIn,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8.0),
          FloatingActionButton(
            mini: true,
            heroTag: 'zoomOut',
            onPressed: onZoomOut,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 8.0),
          FloatingActionButton(
            mini: true,
            heroTag: 'locate',
            onPressed: onLocateUser,
            child: const Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}
