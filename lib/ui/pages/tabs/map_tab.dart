// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proychat/ui/controllers/location_controller.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

// hola
class _MapTabState extends State<MapTab> {
  LocationController loc_controller = Get.find();
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 117, 161, 150),
        body: Center(
          child: Obx(() => Text(
            "Location: ${loc_controller.latitud}, ${loc_controller.longitud}\nOn: ${loc_controller.lastActualization}",
            style: const TextStyle(color: Colors.black),
          )),
        ),
      );
}
