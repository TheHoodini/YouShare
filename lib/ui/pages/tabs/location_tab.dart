// ignore: file_names
import 'package:flutter/material.dart';

class LocationTab extends StatefulWidget {
  const LocationTab({super.key});

  @override
  State<LocationTab> createState() => _LocationTabState();
}

class _LocationTabState extends State<LocationTab> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text(
          'YouShare',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontFamily: 'Montserrat'),
        ),
        backgroundColor: Color.fromARGB(255, 2, 2, 48),
        centerTitle: true,
        elevation: 20.0,
      ),
      body: Center(
          child: Text("Location tab", style: TextStyle(color: Colors.black))));
}
