import 'package:flutter/material.dart';
import 'package:foo/src/song_info.dart';
import 'src/play_bar.dart';

var THEME_BG_COLOR = Colors.grey;
var THEME_FONT_COLOR = Colors.white;
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // State variables
  int queueIndex = 0;
  List<String> currentQueue = [
    "../assets/bees.mp3",
    "../assets/roll.mp3",
    "../assets/all_star.mp3",
    "../assets/baby_shark.mp3",
    "../assets/number_one.mp3"
  ];

  void queueNext() {
    // Bound checking
    if (queueIndex < currentQueue.length - 1)
      setState(() {
        queueIndex++;
      });
    else
      print("OUT OF BOUNDS!");
  }

  void queuePrev() {
    // Bound checking
    if (queueIndex > 0)
      setState(() {
        queueIndex--;
      });
    else
      print("OUT OF BOUNDS!");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: THEME_BG_COLOR,
        appBar: AppBar(
          backgroundColor: THEME_BG_COLOR,
          title: Text(
            'Symphony (name subject to change)',
            style: TextStyle(color: THEME_FONT_COLOR),
          ),
        ),
        body: Column(children: <Widget>[
          Spacer(),
          SongInfo(songTitle: currentQueue[queueIndex]),
          PlayBar(
              queueIndex: queueIndex,
              queueNext: queueNext,
              queuePrev: queuePrev,
              trackSource: currentQueue[queueIndex]),
        ]),
      ),
    );
  }
}
