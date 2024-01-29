import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  //
  //
  Song get currentSong {
    if (currentSongIndex != null && currentSongIndex! < playlist.length) {
      return playlist[currentSongIndex!];
    } else {
      return Song(
        songName: 'Start playing',
        artistName: 'music',
        albumartPath: 'assets/image/cd.png',
        audioPath: '',
        about: '',
      );
    }
  }
  //

  final List<Song> _playlist = [
    Song(
      songName: "Let Me",
      artistName: "ZAYN",
      albumartPath: "assets/image/zayn.jpg",
      audioPath: "audio/letme.mp3",
      about:
          'Zayn Malik, born on January 12, 1993, is an English singer who rose to prominence as a member of One Direction before pursuing a successful solo career. Known for his distinctive voice, he released albums such as "Mind of Mine" and "Icarus Falls."',
    ),
    //
    //
    //
    Song(
      songName: "For You (With Rita Ora)",
      artistName: "Liam Payne & Rita Ora",
      albumartPath: "assets/image/rita.jpg",
      audioPath: "audio/foryou.mp3",
      about:
          'Rita Ora, born on November 26, 1990, in Pristina, Kosovo (formerly Yugoslavia), is a British singer, songwriter, and actress.  In addition to her music career, Rita Ora has ventured into acting, with roles in movies like "Fifty Shades of Grey" and TV shows like "Americas Next Top Model".',
    ),
    //
    //
    //
    Song(
      songName: "Try Me (feat. Jennifer Lopez & Matoma)",
      artistName: "Jason Derulo",
      albumartPath: "assets/image/jason.jpg",
      audioPath: "audio/tryme.mp3",
      about:
          'Jason Derulo, born Jason Joel Desrouleaux on September 21, 1989, is an American singer, songwriter, and dancer. He rose to fame in the late 2000s & early 2010s with hit singles like "Whatcha Say," "In My Head," and "Talk Dirty." Derulo is known for his pop, R&B music & impressive dance skills.',
    ),
    //
    //
    //
    Song(
      songName: "Just A Dream",
      artistName: "Nelly",
      albumartPath: "assets/image/nelly.jpg",
      audioPath: "audio/justadream.mp3",
      about:
          'Nelly, whose full name is Cornell Iral Haynes Jr., is an American rapper, singer, and songwriter. Born on November 2, 1974, in Austin, Texas, he gained widespread fame in the early 2000s with hits like "Hot in Herre," "Dilemma" (featuring Kelly Rowland), and "Country Grammar."',
    ),
  ];
  //
  //

  int? _currentSongIndex;

  //

  final AudioPlayer _audioPlayer = AudioPlayer();

  //

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //

  PlaylistProvider() {
    listenToDuration();
  }

  //

  bool _isPlaying = false;

  //

  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  //

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }
  //

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //

  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  //

  void playPreviousSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  //

  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  //

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;
  //
  //
  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if (newIndex != null) {
      play();
    }
    notifyListeners();
  }
}
