import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController {
  GoogleMapController? _controller;
  CameraPosition? _currentPosition;


  void setController(GoogleMapController controller) {
    _controller = controller;
  }

  void updateCameraPosition(CameraPosition position) {
    _currentPosition = position;
  }

  Future<void> zoomIn() async {
    if (_controller != null) {
      await _controller!.animateCamera(CameraUpdate.zoomIn());
    }
  }

  Future<void> zoomOut() async {
    if (_controller != null) {
      await _controller!.animateCamera(CameraUpdate.zoomOut());
    }
  }

  Future<void> locateUser(LatLng position) async {
    if (_controller != null) {
      await _controller!.animateCamera(
        CameraUpdate.newLatLngZoom(position, 14.0),
      );
    }
  }

  CameraPosition? get currentPosition => _currentPosition;

}
