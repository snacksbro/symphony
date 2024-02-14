import 'package:flutter/material.dart';
import 'package:foo/src/parse_metadata.dart';

class SongInfo extends StatefulWidget {
  final String songTitle;
  const SongInfo({super.key, required this.songTitle});

  @override
  State<SongInfo> createState() => _SongInfoState();
}

class _SongInfoState extends State<SongInfo> {
  Widget build(BuildContext context) {
    MetaObject realTitle = new MetaObject(widget.songTitle);
    return FutureBuilder<void>(
        future: realTitle.initialize(),
        builder: (context, snapshot) {
          // realTitle.initialize();
          print("Song title" + realTitle.songArtist);
          return Row(
              children: <Widget>[Text('Now Playing: ${realTitle.songTitle}')]);
        });
  }
}
