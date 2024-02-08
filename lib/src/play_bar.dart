import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayBar extends StatefulWidget {
  const PlayBar({super.key});
  @override
  State<PlayBar> createState() => _PlayBarState();
}

class _PlayBarState extends State<PlayBar> {
  late bool playing;
  late bool songSelected;
  final player = AudioPlayer();

  @override
  void initState() {
    // Initially, it's not playing anything, nor is there a song selected
    super.initState();
    playing = false;
    songSelected = false;
  }

  @override
  void dispose() {
    // Discard the player and constructor when PlayBar is terminated
    player.dispose();
    super.dispose();
  }

  void play() {
    // TODO: Replace default track
    AssetSource track = AssetSource("../assets/roll.mp3");

    if (!playing) {
      if (!songSelected) {
        // Play the track
        player.play(track);
        setState(() {
          songSelected = true;
        });
      }
      // Resume playing
      player.resume();
      setState(() {
        playing = true;
      });
    } else {
      // Pause playing
      player.pause();
      setState(() {
        playing = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton.icon(
          icon: Icon(Icons.play_arrow),
          label: Text(playing ? "Stop!" : "Play!"),
          onPressed: play,
        ),
      ],
    );
  }
}
