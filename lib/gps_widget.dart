import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'src/widgets.dart';

class GPSWidget extends StatefulWidget {
  const GPSWidget({super.key});
  @override
  GPSWidgetState createState() => GPSWidgetState();
}

class GPSWidgetState extends State<GPSWidget> {
  String _locationMessage = "";
  LatLng _currentLocation = const LatLng(-0.210011, -78.485954);
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController(); // Inicializar _mapController
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _locationMessage =
            "Latitud: ${position.latitude}\nLongitud: ${position.longitude}";
        _currentLocation = LatLng(position.latitude, position.longitude);
        // Mueve el mapa a la ubicación actual
        _mapController.move(_currentLocation, 15.0);
      });
    } catch (e) {
      if (e is LocationServiceDisabledException) {
        setState(() {
          _locationMessage = "Location services are disabled.";
        });
      } else if (e is PermissionDeniedException) {
        setState(() {
          _locationMessage = "Location permissions are denied.";
        });
      } else {
        setState(() {
          _locationMessage = "Failed to get location: $e";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Mapa
        SizedBox(
          height: 300,
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation,
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentLocation,
                    width: 80.0,
                    height: 80.0,
                    child: Container(
                      color: Colors.red,
                      child: const Icon(Icons.location_on,
                          color: Colors.white, size: 40.0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Paragraph(
          'Presiona el botón para ver tu ubicación en tiempo real',
        ),
        const SizedBox(height: 20),
        Text(
          _locationMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        StyledButton(
          onPressed: _getCurrentLocation,
          child: const Text('Ver mi ubicación'),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
