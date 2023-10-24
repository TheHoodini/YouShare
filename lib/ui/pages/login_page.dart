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
                textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(13, 0, 10, 0),
                child: Text('Sign in',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(
                height: 10.0,
              ),
              // NAME
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextFormField(
                    decoration: const InputDecoration(
                  labelText: 'Name',
                  floatingLabelBehavior: FloatingLabelBehavior.never
                )),
              ),
              // USERNAME
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                    decoration: const InputDecoration(
                  labelText: 'Username',
                  floatingLabelBehavior: FloatingLabelBehavior.never
                )),
              ),
              // PASSWORD
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                    decoration: const InputDecoration(
                  labelText: 'Password',
                  floatingLabelBehavior: FloatingLabelBehavior.never
                )),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 10, 0, 20),
                child: Text('Already have an account? Login!',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white)),
                        
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(
                      width: 0.0,
                    ),
                    // BOTÓN SIGN UP
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(40),
                          backgroundColor: Color.fromARGB(255, 2, 155, 69),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16))),
                      child: const Text("Sign In!",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      width: 0.0,
                    ),
                  ]),
              const SizedBox(
                height: 5.0,
              ),
            ]))
      ],
    ));
  }
}
