// ignore: file_names
import 'package:flutter/material.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  Color mainTextColor = Colors.white;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 2, 11, 44),
        body: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Press ',
                  style: TextStyle(
                      color: mainTextColor, fontFamily: "Montserrat")),
              Icon(Icons.person_add, color: mainTextColor),
              Text(' to add someone here!',
                  style: TextStyle(
                      color: mainTextColor, fontFamily: "Montserrat")),
            ],
          ),
        ),
      );
}
