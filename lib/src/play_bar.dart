import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:foo/src/song_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  Duration songProgress = Duration(seconds: 0);
  Duration songDuration = Duration(seconds: 1);
  final player = AudioPlayer();

  @override
  void initState() {
    // Initially, it's not playing anything, nor is there a song selected
    super.initState();
    playing = false;
    songSelected = false;

    player.onPositionChanged.listen((event) {
      setState(() {
        songProgress = event;
      });
    });
    player.onDurationChanged.listen((event) {
      setState(() {
        songDuration = event;
      });
    });
  }

  @override
  void dispose() {
    // Discard the player and constructor when PlayBar is terminated
    player.dispose();
    super.dispose();
  }

  void next() {
    widget.queueNext();
    songSelected = false;
    playing = false;
    // This delay needs to happen due to a Flutter bug
    // setState isn't blocking, so components can render with wrong states
    Future.delayed(Duration(milliseconds: 50)).then((_) {
      play();
    });
  }

  void prev() {
    widget.queuePrev();
    songSelected = false;
    playing = false;
    Future.delayed(Duration(milliseconds: 50)).then((_) {
      play();
    });
  }

  void play() {
    // TODO: Redo some of the logic around songSelected
    // TODO: Replace default track
    AssetSource track = AssetSource(widget.trackSource);

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

  void update_progess(double val) {
    setState(() {
      songProgress = new Duration(seconds: val.toInt());
      player.seek(songProgress);
    });
  }

  String prettyDuration(String stringDuration) {
    // Remove the hours
    // int colonIndex = stringDuration.indexOf(":");
    // stringDuration.substring(colonIndex+1);
    String noMilString = stringDuration.split(".")[0];
    List<String> times = noMilString.split(":");

    return "${times[1]}:${times[2]}";
  }

  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(children: <Widget>[
        Text("-" + prettyDuration((songProgress - songDuration).toString())),
        Expanded(
          child: Slider(
            value: songProgress.inSeconds.toDouble(),
            max: songDuration.inSeconds.toDouble(),
            // Seems as silky as I can make it is per second
            // TODO: Look into firing the event more often?
            divisions: songDuration.inSeconds,
            onChanged: update_progess,
          ),
        ),
        Text(prettyDuration(songDuration.toString()))
      ]),
      Row(
        children: <Widget>[
          Expanded(
            child: ElevatedButton.icon(
              icon: Icon(FontAwesomeIcons.backwardStep),
              label: Text("Prev"),
              onPressed: prev,
            ),
          ),
          Expanded(
            child: ElevatedButton.icon(
              icon: Icon(
                  playing ? FontAwesomeIcons.pause : FontAwesomeIcons.play),
              label: Text(playing ? "Stop!" : "Play!"),
              onPressed: play,
            ),
          ),
          Expanded(
            child: ElevatedButton.icon(
              icon: Icon(FontAwesomeIcons.forwardStep),
              label: Text("Next"),
              onPressed: next,
            ),
          ),
        ],
      )
    ]);
  }
}
