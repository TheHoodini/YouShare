// ignore: file_names
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromARGB(255, 138, 39, 11),
        body: Center(
          child: Text(
            "Add tab",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
}
