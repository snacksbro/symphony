import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:foo/src/song_info.dart';

class PlayBar extends StatefulWidget {
  // TODO: Remove queueIndex since it's no longer needed
  final Function() queueNext;
  final Function() queuePrev;
  final int queueIndex;
  final String trackSource;

  const PlayBar(
      {super.key,
      required this.queueIndex,
      required this.queuePrev,
      required this.trackSource,
      required this.queueNext});

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

  void next() {
    play();
    widget.queueNext();
    songSelected = false;
    playing = false;
  }

  void prev() {
    play();
    widget.queuePrev();
    songSelected = false;
    playing = false;
  }

  void play() {
    // TODO: Redo some of the logic around songSelected
    // TODO: Replace default track
    AssetSource track = AssetSource(widget.trackSource);
    print("Now playing: " + widget.trackSource);

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
