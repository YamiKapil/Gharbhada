import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class SelectLocationMaps extends StatefulWidget {
  final LatLng? latlng;
  final String? address;
  const SelectLocationMaps({
    super.key,
    this.latlng,
    this.address,
  });

  @override
  State<SelectLocationMaps> createState() => _SelectLocationMapsState();
}

class _SelectLocationMapsState extends State<SelectLocationMaps>
    with TickerProviderStateMixin {
  LatLng? latlong;
  String? address;
  TextEditingController mapTextContoller = TextEditingController();
  final mapController = MapController();

  @override
  void initState() {
    super.initState();
    latlong = widget.latlng;
    address = widget.address;
    mapTextContoller.text = widget.address ?? '';
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  // final List<LocationModel> locationList = [];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        if (value) {
          return;
        }
        Navigator.pop(context, latlong);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context, latlong);
            },
            child: Icon(Icons.arrow_back),
          ),
          title: const Text('Select location'),
        ),
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: widget.latlng != null
                    ? widget.latlng!
                    : const LatLng(
                        27.685657,
                        85.315723,
                      ),
                initialZoom: 14.0,
                onTap: (tapPosition, latlon) async {
                  latlong = latlon;
                  final data = await placemarkFromCoordinates(
                      latlon.latitude, latlon.longitude);
                  address =
                      "${data.first.country}, ${data.first.locality}, ${data.first.street}";
                  mapTextContoller.text = address ?? '';
                  setState(() {});
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                ),
                MarkerLayer(
                  markers: [
                    if (latlong != null)
                      Marker(
                        point: latlong!,
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: Colors.red,
                        ),
                        rotate: true,
                      ),
                  ],
                ),
              ],
            ),
            // Positioned.fill(
            //   top: 10,
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 16.w),
            //     child: Align(
            //       alignment: Alignment.topCenter,
            //       child: Container(
            //         color: context.cardColor,
            //         child: DefaultTextSearchField(
            //           hintText: AppLocalizations.of(context)!.search,
            //           searchController: mapTextContoller,
            //           future: () async {
            //             final data = await Provider.of<LocationProvider>(
            //                     context,
            //                     listen: false)
            //                 .getLocationFromName(mapTextContoller.text);
            //             if (data.isNotEmpty) {
            //               // locationList.clear();
            //               // locationList.addAll(data);
            //               final locaiton = data
            //                   .map((e) => SearchedItem.fromJson({
            //                         'label': e.display_name ?? '',
            //                         'lat': e.lon,
            //                         'long': e.lat,
            //                       }))
            //                   .toList();
            //               log(locaiton.toString(), name: 'lcoation..');
            //               return locaiton;
            //             } else {
            //               return [];
            //             }
            //           },
            //           getSelectedValue: (value) {
            //             final SearchedItem data = value;
            //             log(data.toString(), name: 'dataa');
            //             address = data.label;
            //             mapTextContoller.text = address ?? '';
            //             if (mapTextContoller.text.isNotEmpty) {
            //               latlong = LatLng(
            //                   double.parse(data.lat ?? '27.685657'),
            //                   double.parse(data.long ?? '85.315723'));
            //               _animatedMapMove(latlong!, 16.0);
            //               setState(() {});
            //             }
            //           },
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
