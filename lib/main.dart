import 'package:flutter/material.dart';
import 'package:foo/src/song_info.dart';
import 'src/play_bar.dart';

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
        appBar: AppBar(
          title: Text('Symphony (name subject to change)'),
        ),
        body: Column(children: <Widget>[
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
