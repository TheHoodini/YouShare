import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideoWidget extends StatefulWidget {
  const BackgroundVideoWidget({super.key});

  @override
  State<BackgroundVideoWidget> createState() => _BackgroundVideoWidgetState();
}

class _BackgroundVideoWidgetState extends State<BackgroundVideoWidget> {
  late final VideoPlayerController videoController;
  @override
  void initState(){
    videoController = VideoPlayerController.asset('assets/earth.mp4')
    ..initialize().then((context){
      videoController.play();
      videoController.setLooping(true);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => VideoPlayer(videoController);

}