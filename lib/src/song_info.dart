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
          return Column(children: <Widget>[
            Text('Song Artist: ${realTitle.songArtist}'),
            Text('Song Album: ${realTitle.songAlbum}'),
            Text('Now Playing: ${realTitle.songTitle}')
          ]);
        });
  }
}
