// ignore: file_names
import 'package:flutter/material.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 51, 124),
        body: const Center(
          child: Text(
            "Map tab",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
}
