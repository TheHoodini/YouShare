import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// LOGIN y CREATE
import 'package:proychat/ui/pages/createbox.dart';
import 'package:proychat/ui/pages/loginbox.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  static int mainPageIndex = 0;

  late final VideoPlayerController _videoController;
  _AuthPageState() {
    _videoController = VideoPlayerController.asset('assets/earth.mp4')
      ..initialize().then((_) {
        _videoController.play();
        _videoController.setLooping(true);
        setState(() {});
      });
  }

  final screens = <Widget>[];

  @override
  void initState() {
    super.initState();
    screens.add(LoginBox(changeMainPageIndex: changeMainPageIndex));
    screens.add(CreateBox(changeMainPageIndex: changeMainPageIndex));
  }

  void changeMainPageIndex(int newIndex) {
    setState(() {
      mainPageIndex = newIndex;
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
                    //width: _videoController.value.size?.width ?? 0,
                    //height: _videoController.value.size?.height ?? 0 ?? 0,
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController),
                  ))),
          Center(
            child: screens[mainPageIndex],
          ),
        ],
      ),
    );
  }
}
