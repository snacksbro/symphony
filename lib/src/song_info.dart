import 'package:flutter/material.dart';

class SongInfo extends StatefulWidget {
  final String songTitle;
  const SongInfo({super.key, required this.songTitle});

  @override
  State<SongInfo> createState() => _SongInfoState();
}

class _SongInfoState extends State<SongInfo> {
  Widget build(BuildContext context) {
    return Row(children: <Widget>[Text('Now Playing: ${widget.songTitle}')]);
  }
}
