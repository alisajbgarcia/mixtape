import 'package:flutter/material.dart';
import 'package:mixtape/screens/tape_creation.dart';
import 'package:mixtape/screens/tape_info_screen.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/screens/search_page.dart';
import '../models/PlaylistInfo.dart';
import '../models/SongInfo.dart';



// class Song {
//   String title;
//   String artist;
//   String album;
//
//   Song(this.title, this.artist, this.album);
// }

class MixTapeInfo {
  String title;
  String image;
  int numSongs;
  List<SongInfo> songs;
  String description;

  MixTapeInfo(this.title, this.image, this.numSongs, this.songs, [this.description = ""]);
}

class PlaylistScreen extends StatefulWidget {
  final Playlist playlist;
  const PlaylistScreen({required this.playlist});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {

  // API call to get playlist info
  late List<SongInfo> songs;
  late List<MixTapeInfo> cardData;

  @override
  void initState() {
    super.initState();

    List<SongInfo> tameImpala = [
      SongInfo("Be Above It", "Tame Impala", "Lonerism", 302),
      SongInfo("Endors Toi", "Tame Impala", "Lonerism", 271),
      SongInfo("Apocalypse Dreams", "Tame Impala", "Lonerism", 210),
      SongInfo("Mind Mischief", "Tame Impala", "Lonerism", 215),
      SongInfo("Music to Walk Home By", "Tame Impala", "Lonerism", 211),
      SongInfo("Keep on Lying", "Tame Impala", "Lonerism", 177),
      SongInfo("Elephant", "Tame Impala", "Lonerism", 210),
    ];

    List<SongInfo> rock = [
      SongInfo("Someday", "The Strokes", "Is This It", 213),
      SongInfo("Eleanor Rigby", "The Beatles", "Revolver", 293),
      SongInfo("Easy", "HARBOUR", "Thoughts on Letting Go", 299),
      SongInfo("Treasure", "Bruno Mars", "Unorthodox Jukebox", 210),
      SongInfo("I was sad last night I'm OK Now", "tobi lou", "Live on ice", 221),
      SongInfo("Pepas", "Farruko", "Pepas", 177),
      SongInfo("Follow You", "Imagine Dragons", "Mercury - Act 1", 210),
    ];

    List<SongInfo> defaultTape = [
      SongInfo("The Less I Know the Better", "Tame Impala", "Currents", 213),
      SongInfo("Eventually", "Tame Impala", "Currents", 293),
      SongInfo("Monster", "Eminem", "Currents", 299),
      SongInfo("Treasure", "Bruno Mars", "Unorthodox Jukebox", 210),
      SongInfo("I was sad last night I'm OK Now", "tobi lou", "Live on ice", 221),
      SongInfo("Pepas", "Farruko", "Pepas", 177),
      SongInfo("Follow You", "Imagine Dragons", "Mercury - Act 1", 210),
    ];

    switch(widget.playlist.name) {
      case "ish and charlie like to party":
        songs = defaultTape;
        break;
      case "group running playlist":
        songs = rock;
        break;
      default:
        songs = tameImpala;
    }

    // Initialize cardData
    cardData = [
      MixTapeInfo('tame impala da goat', 'assets/green_colored_logo.png', 20, songs, "This is about tame impala"),
      MixTapeInfo('good stuff', 'assets/blue_colored_logo.png', 30, rock, "This playlist does in fact have the good stuff"),
      MixTapeInfo('another mixtape', 'assets/red_colored_logo.png', 50, defaultTape, "Just another mixtape"),
    ];
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: MixTapeColors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                  child: Image.asset(
                    'assets/mixtape_image.png',
                    scale: 1.01,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: screenHeight * .06, // Adjust the top position as needed
                  child: Center(
                    child: Container(
                      height: screenHeight * .05, // Set
                      width: screenWidth * .55,
                      decoration: BoxDecoration(
                        color: MixTapeColors.black.withOpacity(.5), // Set the background color to gray
                        borderRadius: BorderRadius.circular(3), // Add rounded corners
                      ),
                      child:FittedBox(
                        fit: BoxFit.scaleDown, // This makes the text shrink to fit
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            widget.playlist.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: screenHeight * .22, // Adjust the top position as needed
                  child: Center(
                    child: Container(
                      height: screenHeight * .05, // Set
                      width: screenWidth * .55,
                      decoration: BoxDecoration(
                        color: MixTapeColors.black.withOpacity(.5), // Set the background color to gray
                        borderRadius: BorderRadius.circular(3), // Add rounded corners
                      ),
                      child:FittedBox(
                        fit: BoxFit.scaleDown, // This makes the text shrink to fit
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "${getTotalNumSongs()} songs, ${getTotalTimeHHMM()}",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView( // Use SingleChildScrollView instead of ListView
                child: Column(
                  children: cardData.map((mixtape) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () {
                        print('Tapped on Card ${mixtape.title}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TapeInfoScreen(tape_id: 1, spotify_id: 2, title: mixtape.title, image: mixtape.image, songs: mixtape.songs, description: mixtape.description,)),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                        ),
                        elevation: 0.0,
                        color: MixTapeColors.dark_gray,
                        margin: EdgeInsets.all(15.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Container(
                            color: MixTapeColors.dark_gray,
                            height: screenHeight * .25,
                            width: screenWidth * .9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 20, 10, 0),
                                  child: Text(
                                    mixtape.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: (21 * textScaleFactor),
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: screenWidth * .9,
                                  height: screenHeight * .07,
                                  color: MixTapeColors.dark_gray,
                                  child: Card(
                                    elevation: 0.0,
                                    color: MixTapeColors.dark_gray,
                                    child: ListTile(
                                      leading: Image.asset(
                                        mixtape.image,
                                        width: screenWidth * .1,
                                        height: screenHeight * .1,
                                      ),
                                      title: Text(
                                        mixtape.songs[0].title,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: textScaleFactor * 13,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${mixtape.songs[0].artist} • ${mixtape.songs[0].album}",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontSize: textScaleFactor * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * .01,
                                ),
                                Container(
                                  width: screenWidth * .9,
                                  height: screenHeight * .07,
                                  color: MixTapeColors.dark_gray,
                                  child: Card(
                                    elevation: 0.0,
                                    color: MixTapeColors.dark_gray,
                                    child: ListTile(
                                      leading: Image.asset(
                                        mixtape.image,
                                        width: screenWidth * .1,
                                        height: screenHeight * .1,
                                      ),
                                      title: Text(
                                        mixtape.songs[1].title,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: textScaleFactor * 13,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${mixtape.songs[1].artist} • ${mixtape.songs[1].album}",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontSize: textScaleFactor * 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(screenWidth * .64,0,0,0),
                                    child: FloatingActionButton.extended(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                                      ),
                                      heroTag: "mixtape_creation",
                                      onPressed: () {
                                        print("add to queue");
                                        /* Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => PlaylistCreationScreen()),
                                         ); */
                                      },
                                      label: Padding(
                                        padding: EdgeInsets.fromLTRB(1,1,1,1),
                                        child: Text(
                                          'Queue',
                                          style: TextStyle(
                                            fontSize: textScaleFactor * 15,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      backgroundColor: MixTapeColors.green, // Change the button's color
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * .05),
              child: FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                ),
                heroTag: "mixtape_creation",
                onPressed: () {
                  print("create mixtape");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TapeCreationScreen(playlist: widget.playlist)),
                  );
                },
                label: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Add a MixTape',
                    style: TextStyle(
                      fontSize: textScaleFactor * 20,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                icon: Icon(Icons.add),
                backgroundColor: MixTapeColors.green, // Change the button's color
              ),
            ),
          ],
        ),
      ),
    );
  }

  int getTotalNumSongs() {
    int totalSongs = 0;
    for (MixTapeInfo card in cardData) {
      totalSongs += card.numSongs;
    }
    return totalSongs;
  }

  String getTotalTimeHHMM() {
    double totalSeconds = 0;
    for (MixTapeInfo card in cardData) {
      for (SongInfo song in card.songs) {
        totalSeconds += song.duration;
      }
    }
    int hours = getHoursFromSeconds(totalSeconds);
    int minutes = getMinutesFromSeconds(totalSeconds) - hours * 60;
    return "${hours}h ${minutes}m";
  }

  int getHoursFromSeconds(double seconds) {
    return (seconds / 3600).round();
  }

  int getMinutesFromSeconds(double seconds) {
    return (seconds / 60).round();
  }
}
