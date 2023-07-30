import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

    CameraPosition puntoInicial =
        CameraPosition(target: scan.getLatLng(), zoom: 17.5, tilt: 50);

    Set<Marker> mapMarker = <Marker>{};

    mapMarker.add(
      Marker(
          markerId: const MarkerId('Geo-Location'), position: scan.getLatLng()),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapas'),
      ),
      body: GoogleMap(
        mapType: MapType.terrain,
        markers: mapMarker,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
