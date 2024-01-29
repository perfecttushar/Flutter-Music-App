import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/models/playlist_provider.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  String formatTime(Duration duration) {
    String twoDigitsSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedtTime = "${duration.inMinutes}:$twoDigitsSeconds";

    return formattedtTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        //
        //
        final playlist = value.playlist;
        //
        //
        final currentSong = playlist[value.currentSongIndex ?? 0];
        //
        //
        return Scaffold(
          body: Stack(
            children: [
              //
              // Background Blur
              //
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(currentSong.albumartPath),
                      fit: BoxFit.cover),
                ),
              ),
              ClipRRect(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              //
              // Custom App Bar
              //
              Column(
                children: [
                  //
                  //
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_left_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Now Playing',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //
                  // Song, Artist Name & Media Controls
                  //
                  const SizedBox(height: 360),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSong.songName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          currentSong.artistName,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey.shade400,
                          ),
                        ),

                        //
                        // Slider
                        //

                        const SizedBox(height: 30),
                        Column(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 2,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 0,
                                ),
                                overlayShape: SliderComponentShape.noOverlay,
                              ),
                              child: Container(
                                child: Slider(
                                  min: 0,
                                  max: value.totalDuration.inSeconds.toDouble(),
                                  value: value.currentDuration.inSeconds
                                      .toDouble(),
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.grey.shade500,
                                  onChanged: (double double) {},
                                  onChangeEnd: (double double) {
                                    value.seek(
                                        Duration(seconds: double.toInt()));
                                  },
                                ),
                              ),
                            ),
                            //
                            //
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatTime(value.currentDuration),
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  Text(
                                    formatTime(value.totalDuration),
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        //
                        // Media Controls
                        //

                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //
                            const Icon(
                              Icons.lyrics_outlined,
                              color: Colors.white,
                            ),
                            //
                            IconButton(
                              onPressed: () {
                                value.playPreviousSong();
                              },
                              icon: const Icon(
                                Icons.skip_previous_rounded,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                            //
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: FloatingActionButton(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                onPressed: () {
                                  value.pauseOrResume();
                                },
                                child: Icon(
                                  value.isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  color: Colors.black,
                                  size: 35,
                                ),
                              ),
                            ),
                            //
                            IconButton(
                              onPressed: () {
                                value.playNextSong();
                              },
                              icon: const Icon(
                                Icons.skip_next_rounded,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                            //
                            const Icon(
                              Icons.favorite_outline_rounded,
                              color: Colors.white,
                            ),
                            //
                          ],
                        ),

                        //
                        // About the artist
                        //

                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          'About the artist',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade300,
                              fontSize: 15),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          currentSong.about,
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins(
                              color: Colors.grey.shade400, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
