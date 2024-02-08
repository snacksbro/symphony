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
  late int queueIndex;
  final player = AudioPlayer();
  List<String> currentQueue = [
    "../assets/roll.mp3",
    "../assets/all_star.mp3",
    "../assets/baby_shark.mp3",
    "../assets/number_one.mp3"
  ];

  @override
  void initState() {
    // Initially, it's not playing anything, nor is there a song selected
    super.initState();
    playing = false;
    songSelected = false;
    queueIndex = 0;
  }

  @override
  void dispose() {
    // Discard the player and constructor when PlayBar is terminated
    player.dispose();
    super.dispose();
  }

  void next() {
    // Bound checking
    if (queueIndex < currentQueue.length - 1)
      queueIndex++;
    else
      print("OUT OF BOUNDS!");

    songSelected = false;
    playing = false;
    play();
  }

  void prev() {
    // Bound checking
    if (queueIndex > 0)
      queueIndex--;
    else
      print("OUT OF BOUNDS!");

    songSelected = false;
    playing = false;
    play();
  }

  void play() {
    // TODO: Redo some of the logic around songSelected
    // TODO: Replace default track
    AssetSource track = AssetSource(currentQueue[queueIndex]);

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
    return Row(
      children: <Widget>[
        ElevatedButton.icon(
          icon: Icon(Icons.play_arrow),
          label: Text("Prev"),
          onPressed: prev,
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.play_arrow),
          label: Text(playing ? "Stop!" : "Play!"),
          onPressed: play,
        ),
        ElevatedButton.icon(
          icon: Icon(Icons.play_arrow),
          label: Text("Next"),
          onPressed: next,
        ),
      ],
    );
  }
}
