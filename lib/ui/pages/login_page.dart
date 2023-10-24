import 'package:flutter/material.dart';
import 'package:proychat/video_widget.dart';
import 'package:video_player/video_player.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  late final VideoPlayerController _videoController;
  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/earth.mp4')
      ..initialize().then((_) {
        _videoController.play();
        _videoController.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SizedBox.expand(
            child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController.value.size?.width ?? 0,
                  height: _videoController.value.size?.height ?? 0 ?? 0,
                  child: VideoPlayer(_videoController),
                ))),
        Center(
            child: SimpleDialog(
                backgroundColor:
                    const Color.fromARGB(255, 0, 51, 124).withOpacity(0.7),
                // Aquí puede ir el logo en vez del Text()
                // title: Image.asset("assets/logo.png", height: 120),
                title: const Text('YouShare',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                children: [
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Username')),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  decoration: const InputDecoration(labelText: 'Password')),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(42),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: const Text("Submit"),
              )
            ]))
      ],
    ));
  }
}
