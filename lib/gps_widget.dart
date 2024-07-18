import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'src/widgets.dart';

class GPSWidget extends StatefulWidget {
  const GPSWidget({super.key});
  @override
  GPSWidgetState createState() => GPSWidgetState();
}

class GPSWidgetState extends State<GPSWidget> {
  String _locationMessage = "";

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _locationMessage =
            "Latitud: ${position.latitude}\nLongitud: ${position.longitude}";
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
        Image.asset('images/mapa.png', height: 350, width: 350),
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
