import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class adminlocation extends StatefulWidget {
  adminlocation({super.key});

  @override
  State<adminlocation> createState() => _adminlocationState();
}

class _adminlocationState extends State<adminlocation> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late GoogleMapController _mapController;
  LatLng _selectedLocation = const LatLng(7.290572, 80.633728);
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
          _selectedLocation = _markers.first.position;
        });
      }
    } catch (e) {
      print("Error fetching locations: $e");
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController.moveCamera(CameraUpdate.newLatLng(_selectedLocation));
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _selectedLocation = position.target;
      _markers
          .removeWhere((marker) => marker.markerId == MarkerId('centerMarker'));
      _markers.add(
        Marker(
          markerId: MarkerId('centerMarker'),
          position: _selectedLocation,
          draggable: true,
        ),
      );
    });
  }

  Future<void> _updateLocation() async {
    try {
      await firestore.collection('locations').add({
        'latitude': _selectedLocation.latitude,
        'longitude': _selectedLocation.longitude,
        'timestamp': DateTime.now().toIso8601String(),
      });
      showUploadSuccessDialog(context);
      _fetchAllLocations();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update location: $e')),
      );
    }
  }

  void showUploadSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 31, 160, 143),
          title: const Text(
            "Location Updated",
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            "Pickup Location has been updated successfully.",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAllLocations() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('locations').get();
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
      setState(() {
        _markers.clear();
      });
      showUploadSuccessDialogdelete(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete locations: $e')),
      );
    }
  }

  void showUploadSuccessDialogdelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 31, 160, 143),
          title: const Text(
            "Locations Deleted",
            style: TextStyle(color: Colors.black),
          ),
          content: const Text(
            "Pickup Locations has been deleted successfully.",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(13),
                width: size.width,
                height: size.height * 0.14,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Color.fromARGB(255, 31, 160, 143),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Add Recycling Center",
                        style: GoogleFonts.publicSans(
                            fontWeight: FontWeight.bold,
                            fontSize: size.height * 0.03)),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              SizedBox(
                width: size.width * 0.9,
                height: size.height * 0.6,
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation,
                    zoom: 12.0,
                  ),
                  onMapCreated: _onMapCreated,
                  onCameraMove: _onCameraMove,
                  markers: _markers,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      height: size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          _updateLocation();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow),
                        child: Text(
                          "Update Location",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: size.width * 0.04,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.4,
                      height: size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          _deleteAllLocations();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow),
                        child: Text(
                          "Remove Locations",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: size.width * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
