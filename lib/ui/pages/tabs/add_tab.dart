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
    body: Center(
      child: Text("Add tab", style: TextStyle(color: Colors.black))
    )
  );
}
