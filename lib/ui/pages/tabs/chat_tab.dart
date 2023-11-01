// ignore: file_names
import 'package:flutter/material.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.green,
    appBar: AppBar(
          title: const Text(
            'YouShare',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontFamily: 'Montserrat'),
          ),
          backgroundColor: Color.fromARGB(255, 2, 2, 48),
          centerTitle: true),
    body: const Center(
      child: Text("Chat tab", style: TextStyle(color: Colors.black))
    )
  );
}
