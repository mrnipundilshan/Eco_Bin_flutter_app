import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class location extends StatefulWidget {
  location({super.key});

  @override
  State<location> createState() => _locationState();
}

class _locationState extends State<location> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late GoogleMapController _mapController;
  LatLng _initialLocation = LatLng(7.290572, 80.633728);
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _fetchAllLocations();
  }

  Future<void> _fetchAllLocations() async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('locations')
          .orderBy('timestamp', descending: true)
          .get();
      if (snapshot.docs.isNotEmpty) {
        Set<Marker> markers = {};
        for (var doc in snapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;
          LatLng location = LatLng(data['latitude'], data['longitude']);
          markers.add(
            Marker(
              markerId: MarkerId(doc.id),
              position: location,
            ),
          );
        }
        setState(() {
          _markers = markers;
          _initialLocation = _markers.first.position;
        });
      }
    } catch (e) {
      print("Error fetching locations: $e");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController.moveCamera(CameraUpdate.newLatLng(_initialLocation));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 31, 160, 143),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(13),
                width: size.width,
                height: size.height * 0.14,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 31, 160, 143),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Recycle Centers",
                        style: GoogleFonts.publicSans(
                            fontWeight: FontWeight.bold,
                            fontSize: size.height * 0.04)),
                  ],
                ),
              ),
              SizedBox(
                width: size.width,
                height: size.height * 0.73,
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: _initialLocation,
                    zoom: 12.0,
                  ),
                  onMapCreated: _onMapCreated,
                  markers: _markers,
                ),
              ),
            ],
          )),
    );
  }
}
