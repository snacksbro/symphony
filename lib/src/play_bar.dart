import 'package:flutter/material.dart';
import 'track.dart';

class PlayBar extends StatefulWidget {
  const PlayBar({super.key});
  @override
  State<PlayBar> createState() => _PlayBarState();
  // _PlayBarState createState() => _PlayBarState();
}

class _PlayBarState extends State<PlayBar> {
  bool isPlaying = false;
  Widget build(context) {
    if (playing) {
      return Text("Playing!");
    } else {
      return Text("Stopped!");
    }
  }
}
