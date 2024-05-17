// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);

//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   // List of available houses with their latitude and longitude
//   final List<LatLng> availableHouses = [
//     LatLng(27.717245, 85.323959), // House 1
//     LatLng(27.664400, 85.318794), // House 2
//     LatLng(27.717245, 85.323959), // House 3
//     LatLng(27.664400, 85.319794), // House 4
//     LatLng(27.727245, 85.323959), // House 5
//     LatLng(28.727245, 85.323959), // House 5

//     LatLng(21.408449, 86.345627), // House 6
//     LatLng(27.717245, 85.323959), // House 7
//     LatLng(27.664400, 85.418794), // House 8
//     LatLng(27.717245, 85.323959), // House 9
//     LatLng(27.664400, 85.318794), // House 10

//     // Add more houses as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map Screen'),
//       ),
//       body: FlutterMap(
//         options: MapOptions(
//           initialCenter: LatLng(27.717245, 85.323959), // House 1

//           initialZoom: 10,
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//             userAgentPackageName: 'com.example.app',
//           ),
//           MarkerLayer(
//             markers: availableHouses.map((houseLocation) {
//               return Marker(
//                 width: 50.0,
//                 height: 50.0,
//                 point: houseLocation,
//                 child: GestureDetector(
//                   onTap: () {
//                     print('Marker tapped');
//                     Navigator.of(context).pushNamed('/property-details');
//                   },
//                   child: Icon(
//                     Icons.location_on,
//                     color: Colors.red,
//                     size: 30.0,
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  final String locationAddress;
  final String? lat;
  final String? long;

  const MapPage({
    Key? key,
    required this.locationAddress,
    this.lat,
    this.long,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Map'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(27.7172, 85.324),
          zoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: (widget.lat != null && widget.long != null)
                    ? LatLng(double.tryParse(widget.lat!) ?? 27.7172,
                        double.tryParse(widget.long!) ?? 85.324)
                    : LatLng(27.7172, 85.324),
                child: Container(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 50.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
