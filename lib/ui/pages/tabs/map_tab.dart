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

  Marker friend(name, hour, minut, lat, long, visibility) {
    return Marker(
        markerId: MarkerId(name),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(title: "$hour:$minut", snippet: name),
        visible: visibility);
  }

  Set<Marker> friendMarkers() {
    Set<Marker> markers = {
      Marker(
        markerId: const MarkerId("Me"),
        position: LatLng(locController.userLocation.value.latitude,
            locController.userLocation.value.longitude),
        infoWindow: InfoWindow(
          title: locController.lastActualization.toString().substring(
              locController.lastActualization.toString().length - 6,
              locController.lastActualization.toString().length - 1),
          snippet: controller.name,
        ),
        visible: locController.markerVisibility)
    };
    for (var i = 0; i < controller.friends.length; i++) {
      String usernameVar = controller.friends[i];
      bool isfriend = false;
      var j;
      for (j = 0; j < controller.users.length; j++) {
        if (usernameVar == controller.users[j].username) {
          isfriend = true;
          break;
        }
      }
      if (isfriend) {
        markers.add(friend(
          controller.users[j].name,
          controller.users[j].location[2],
          controller.users[j].location[3],
          controller.users[j].location[0],
          controller.users[j].location[1],
          controller.users[j].location[4],
        ));
      }
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        //backgroundColor: const Color.fromARGB(255, 117, 161, 150),
        body: Obx(
          () => GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(locController.userLocation.value.latitude,
                  locController.userLocation.value.longitude),
              zoom: 5.0,
            ),
            zoomControlsEnabled: false,
            markers: friendMarkers(),
          ),
        ),
      );
}
