import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music/components/mydrawer.dart';
import 'package:music/models/playlist_provider.dart';
import 'package:music/models/song.dart';
import 'package:music/pages/songpage.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  //
  late final dynamic playlistProvider;
  late Song currentSong;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  //
  //

  void goToSong(int songIndex) {
    playlistProvider.currentSongIndex = songIndex;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SongPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      //
      // App Bar
      //

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/image/logo.png',
                height: 30,
              ),
            ),
          ),
        ],
      ),

      drawer: const MyDrawer(),

      //
      // Body
      //

      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playlist;
          currentSong = value.currentSong;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              //

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey Tushar,',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),

                    //

                    Text(
                      'Good to see you! ',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),

              //
              //
              //

              const SizedBox(height: 15),
              SizedBox(
                height: 110,
                width: double.maxFinite,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/image/cover.jpeg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/image/cover2.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //
              //
              const SizedBox(height: 15),
              //
              //

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Playlist',
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '4 tracks • 16 mins',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),

              //
              //
              //
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.75),
                  itemCount: playlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => goToSong(index),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.asset(
                                playlist[index].albumartPath,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    playlist[index].songName,
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    playlist[index].artistName,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              //
              // Bottom Seek Bar
              //

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SongPage();
                        },
                      ),
                    ),
                    child: Container(
                      height: 70,
                      width: double.maxFinite,
                      color: Colors.black87,
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              currentSong.albumartPath,
                              height: 50,
                              width: 50,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  currentSong.songName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  currentSong.artistName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_outline_rounded,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            color: Colors.white,
                            onPressed: () {
                              value.pauseOrResume();
                            },
                            icon: Icon(
                                value.isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                size: 30),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
