import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:huawei_map/map.dart';
class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}
class _MapPageState extends State<MapPage> {
  HuaweiMapController? _mapController;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          _buildMap(),

        ],
      ),
    );
  }
  _buildMap() {
    return HuaweiMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(12.9569, 77.7011),
        zoom: 10.0,
        bearing: 30,
      ),
      onMapCreated: (HuaweiMapController controller) {
        _mapController = controller;
      },
      mapType: MapType.normal,
      tiltGesturesEnabled: true,
      buildingsEnabled: true,
      compassEnabled: true,
      zoomControlsEnabled: true,
      rotateGesturesEnabled: true,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      trafficEnabled: true,
    );
  }
}