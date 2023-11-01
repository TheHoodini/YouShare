// ignore: file_names
import 'package:flutter/material.dart';

class AddTab extends StatefulWidget {
  const AddTab({super.key});

  @override
  State<AddTab> createState() => _AddTabState();
}

class _AddTabState extends State<AddTab> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
          title: const Text(
            'YouShare',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Montserrat'),
          ),
          backgroundColor: Color.fromARGB(255, 2, 2, 48),
          centerTitle: true),
      body: Center(
          child: Text("Add tab", style: TextStyle(color: Colors.black))));
}
