import 'package:flutter/material.dart';
import 'package:proychat/video_widget.dart';
import 'package:video_player/video_player.dart';
//import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const BackgroundVideoWidget(),
        Center(
            child: SimpleDialog(
              backgroundColor: Colors.blue.withOpacity(0.7),
                // Aquí puede ir el logo en vez del HOLA
                // title: Image.asset("assets/logo.png", height: 120),
                title: Text("HOLA"),
                children: [
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Username')),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Password')),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromHeight(42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16))),
                child: const Text("Submit"),)
            ]))
      ],
    ));
  }

}
