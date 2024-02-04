import 'package:audioplayers/audioplayers.dart';
// ...

void initialize() {}

void play() {
  final player = AudioPlayer();
  // AssetSource track = AssetSource("../assets/roll.mp3");
  AssetSource track = AssetSource("../assets/roll.mp3");
  print(track.toString());
  player.play(track);
}
