//key API "AIzaSyB63tXKjGr0fAxxeZIckPMojJbdnubIGDk"

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  final Position posisilong;
  final latpg;
  final longpg;

  const Maps({Key key, this.posisilong, this.latpg, this.longpg})
      : super(key: key);
  @override
  MapsState createState() =>
      MapsState(this.posisilong, this.latpg, this.longpg);
}

PolylinePoints polylinePoints;
Set<Polyline> _polylines = Set<Polyline>();
List<LatLng> polylineCoordinates = [];
Map<PolylineId, Polyline> polylines = {};

class MapsState extends State<Maps> {
  final latpg;
  final longpg;
  //untuk posisi user
  final Position posisilong;
  CameraPosition _initialLocation =
      CameraPosition(target: LatLng(5.047164, 97.316499));

// For controlling the view of the Map
  GoogleMapController mapController;
  MapsState(this.posisilong, this.latpg, this.longpg);

  //Object for PolylinePoints

//Cara tambah marker
  // Map<MarkerId, Marker> markers = {};
  // _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
  //   MarkerId markerId = MarkerId(id);
  //   Marker marker =
  //       Marker(markerId: markerId, icon: descriptor, position: position);
  //   markers[markerId] = marker;
  // }

  @override
  void initState() {
    super.initState();

    _createPolylines();
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers() {
      return <Marker>[
        Marker(
            markerId: MarkerId('nama Penginapan'),
            position: LatLng(latpg, longpg),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: "Hotel"))
      ].toSet();
    }

    // Determining the screen width & height
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // Initial location of the Map view
// ignore: unused_local_variable
    return Scaffold(
      appBar: AppBar(
        title: Text("Lokasi Penginapan"),
      ),
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            // Add Map View
            GoogleMap(
              markers: markers(),
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                _createPolylines();
              },
            ),

            // Show current location button
            SafeArea(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.purpleAccent[100], // button color
                      child: InkWell(
                        splashColor: Colors.purpleAccent, // inkwell color
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.location_pin),
                        ),
                        onTap: () {
                          print("aaajshduashduasd $latpg ");
                          print("aaajshduashduasd $longpg ");
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  latpg,
                                  longpg,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(20),
                    width: 200,
                    color: Colors.purpleAccent[100].withOpacity(0.3),
                    child: Text(
                      "Tekan marker penginapan untuk mendapatkan rute",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  _createPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyB63tXKjGr0fAxxeZIckPMojJbdnubIGDk", // Google Maps API Key
      PointLatLng(posisilong.latitude, posisilong.longitude),
      PointLatLng(latpg, longpg),
      travelMode: TravelMode.driving,
    );

    if (result.status == 'OK') {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      print("{latpg, longpg}");
      _polylines.add(Polyline(
        polylineId: PolylineId('Polyline'),
        color: Colors.red,
        points: polylineCoordinates,
        width: 3,
      ));
    });
  }
}
