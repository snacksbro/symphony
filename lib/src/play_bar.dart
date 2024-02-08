import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'track.dart';

class PlayBar extends StatefulWidget {
  const PlayBar({super.key});
  @override
  State<PlayBar> createState() => _PlayBarState();
  // _PlayBarState createState() => _PlayBarState();
}

class _PlayBarState extends State<PlayBar> {
  late bool playing; // = false;
  late bool songSelected; //= false;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    playing = false;
    songSelected = false;
  }

  void play() {
    AssetSource track = AssetSource("../assets/roll.mp3");

    print(track.toString());
    if (!playing) {
      if (!songSelected) {
        player.play(track);
        setState(() {
          songSelected = true;
        });
      }
      player.resume();
      setState(() {
        playing = true;
      });
    } else {
      //player.stop();
      player.pause();
      setState(() {
        playing = false;
      });
    }
    print(playing);
  }

  // bool isPlaying = false;
  // Widget build(context) {
  //   return Column(
  //     children: <Widget>[
  //       if (playing) {
  //         Text("Playing!");
  //       } else {
  //         Text("Stopped!");
  //       }
  //     ]
  //   );
  // }
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (playing) Text("Playing!") else Text("Stopped!"),
        ElevatedButton.icon(
          icon: Icon(Icons.play_arrow),
          label: Text(playing ? "Play!" : "Stop!"),
          onPressed: play,
        ),
      ],
    );
  }
}
