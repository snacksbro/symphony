import 'package:audioplayers/audioplayers.dart';
// ...

bool playing = false;
bool song_selected = false;
final player = AudioPlayer();

void initialize() {}

void play() {
  AssetSource track = AssetSource("../assets/roll.mp3");

  print(track.toString());
  if (!playing) {
    if (!song_selected) {
      player.play(track);
      song_selected = true;
    }
    player.resume();
    playing = true;
  } else {
    //player.stop();
    player.pause();
    playing = false;
  }
  print(playing);
}
