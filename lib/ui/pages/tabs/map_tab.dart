// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proychat/ui/controllers/location_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proychat/ui/controllers/user_controller.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

// hola
class _MapTabState extends State<MapTab> {
  LocationController locController = Get.find();
  UserController controller = Get.find();

  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        //backgroundColor: const Color.fromARGB(255, 117, 161, 150),
        body: Obx(
          () => GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(locController.userLocation.value.latitude, locController.userLocation.value.longitude),
              zoom: 5.0,
            ),
            zoomControlsEnabled: false,
            markers: {
              Marker(
                  markerId: const MarkerId("Me"),
                  position:
                      LatLng(locController.userLocation.value.latitude, locController.userLocation.value.longitude),
                  infoWindow: InfoWindow(
                    title: "Me",
                    snippet: controller.name,
                  ),
                  visible: locController.markerVisibility), // Marker
            },
          ),
        ),
      );
}
