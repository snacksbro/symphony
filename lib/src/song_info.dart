import 'package:flutter/material.dart';
import 'package:foo/src/play_bar.dart';

class SongInfo extends StatefulWidget {
  final String songTitle;
  const SongInfo({super.key, required this.songTitle});

  @override
  State<SongInfo> createState() => _SongInfoState();
}

class _SongInfoState extends State<SongInfo> {
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      // Text('Now Playing: ${PlayBar.currentQueue[PlayBar.queueIndex]}')
      Text('Now Playing: ${widget.songTitle}')
    ]);
  }
}
