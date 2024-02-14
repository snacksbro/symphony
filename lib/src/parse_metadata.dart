import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'dart:convert';

int headerCharCount = 500;

class MetaObject {
  String songPath;
  String songArtist = "";
  String songAlbum = "";
  String songTitle = "";

  MetaObject(this.songPath) {}

  Future<void> initialize() async {
    List<String> songMetadata = await getHeader();
    songArtist = trimToHeaderChar(songMetadata[0]);
    songAlbum = trimToHeaderChar(songMetadata[1]);
    songTitle = trimToHeaderChar(songMetadata[2]);
  }

  String trimToHeaderChar(String str) {
    for (int i = 0; i < str.length; i++) {
      if (str.codeUnitAt(i) == 3) {
        return str.substring(i + 1);
      }
    }
    return str;
  }

  // Future<Uint8List> loadSong() async {

  // Convert the data to UTF-8 encoding
  // String decodedData = utf8.decode(songData);
  // Uint8List utf8EncodedData = utf8.encode(decodedData);
  // getHeader(songData);
  // return data.buffer.asUint8List();
  // }

  Future<List<String>> getHeader() async {
    // Loading in the song
    ByteData data = await rootBundle.load(songPath);
    Uint8List songData = data.buffer.asUint8List();

    // Ripping out the header
    List<int> header = songData.sublist(0, headerCharCount);

    // Decoding it
    String decoded_header = latin1.decode(header);

    // Parse out the values
    List<String> album_arr = decoded_header.split("TALB");
    List<String> artist_arr = album_arr[1].split("TPE1");
    String song_album = artist_arr[0];
    List<String> title_arr = artist_arr[1].split("TIT2");
    String song_artist = title_arr[0];
    List<String> newline_arr = title_arr[1].split("TSSE");
    String song_title = newline_arr[0];

    // Printing for good measure
    // print("TITLE IS " + song_title);
    // print("ALBUM IS " + song_album);
    // print("ARTIST IS " + song_artist);
    // Preceeds ^C for chars? May be how to fix the title
    return [song_artist, song_album, song_title];
  }

  String getFormat() {
    // TODO: Make this handle multiple periods in filename
    return songPath.split(".")[1];
  }
}
