import 'package:flutter/material.dart';
import 'package:mixtape/models/mixtape.dart';
import 'package:mixtape/screens/tape_creation.dart';
import 'package:mixtape/screens/tape_info_screen.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/screens/search_page.dart';
import '../models/playlist.dart';
import '../models/track_info.dart';
import '../services/authentication_service.dart';
import '../services/mixtape_service.dart';
import '../services/services_container.dart';

class MixTapeInfo {
  String title;
  String image;
  int numSongs;
  List<TrackInfo> songs;
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
  late List<TrackInfo> songs;
  late Future<List<Mixtape>> cardData;
  late AuthenticationService authenticationService;
  late MixtapeService mixtapeService;

  @override
  void initState() {
    super.initState();

    mixtapeService = ServicesContainer.of(context).mixtapeService;
    authenticationService = ServicesContainer.of(context).authService;
    setState(() {
      cardData = mixtapeService.getMixtapesForPlaylistCurrentUser(widget.playlist.id);
    });

    List<TrackInfo> tameImpala = [
      TrackInfo(id: '123', name: 'hello there', artistNames: ['artist'], albumName: 'album', albumImageURL: 'assets/green_colored_logo.png' ),
      TrackInfo(id: '123', name: 'hello there', artistNames: ['artist'], albumName: 'album', albumImageURL: 'assets/green_colored_logo.png' ),
      TrackInfo(id: '123', name: 'hello there', artistNames: ['artist'], albumName: 'album', albumImageURL: 'assets/green_colored_logo.png' ),
    ];

    List<TrackInfo> rock = [
      TrackInfo(id: '123', name: 'hello there', artistNames: ['artist'], albumName: 'album', albumImageURL: 'assets/green_colored_logo.png' ),
      TrackInfo(id: '123', name: 'hello there', artistNames: ['artist'], albumName: 'album', albumImageURL: 'assets/green_colored_logo.png' ),
    ];

    List<TrackInfo> defaultTape = [
      TrackInfo(id: '123', name: 'hello there', artistNames: ['artist'], albumName: 'album', albumImageURL: 'assets/green_colored_logo.png' ),
      TrackInfo(id: '123', name: 'hello there', artistNames: ['artist'], albumName: 'album', albumImageURL: 'assets/green_colored_logo.png' ),
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

    // // Initialize cardData
    // cardData = [
    //   MixTapeInfo('tame impala da goat', 'assets/green_colored_logo.png', 20, songs, "This is about tame impala"),
    //   MixTapeInfo('good stuff', 'assets/blue_colored_logo.png', 30, rock, "This playlist does in fact have the good stuff"),
    //   MixTapeInfo('another mixtape', 'assets/red_colored_logo.png', 50, defaultTape, "Just another mixtape"),
    // ];
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      body: FutureBuilder(
          future: cardData,
          builder: (context, profileSnapshot) {

            if (!profileSnapshot.hasData || profileSnapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }

            // null assert is hella ugly, but the compiler doesn't appear to tell
            // that this won't be null because of the early return
            final cardData = profileSnapshot.data!;


            return Container(
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
                        print('Tapped on Card ${mixtape.name}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TapeInfoScreen(tape_id: 1, spotify_id: 2, title: mixtape.name, songs: mixtape.songs, description: mixtape.description,)),
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
                                    mixtape.name,
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
                                        mixtape.songs[0].albumImageURL,
                                        width: screenWidth * .1,
                                        height: screenHeight * .1,
                                      ),
                                      title: Text(
                                        mixtape.songs[0].name,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: textScaleFactor * 13,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${mixtape.songs[0].artistNames[0]} • ${mixtape.songs[0].albumName}",
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
                                        mixtape.songs[1].albumImageURL,
                                        width: screenWidth * .1,
                                        height: screenHeight * .1,
                                      ),
                                      title: Text(
                                        mixtape.songs[1].name,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: textScaleFactor * 13,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${mixtape.songs[1].artistNames[0]} • ${mixtape.songs[1].albumName}",
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
      );}
            ),
    );
  }

  int getTotalNumSongs() {
    //TODO: COME BACK AND FIX THIS
    // int totalSongs = 0;
    // for (MixTapeInfo card in cardData) {
    //   totalSongs += card.numSongs;
    // }
    // return totalSongs;
    return 100;
  }

  String getTotalTimeHHMM() {
    //TODO: COME BACK AND FIX THIS
    // double totalSeconds = 0;
    // for (MixTapeInfo card in cardData) {
    //   for (TrackInfo song in card.songs) {
    //     totalSeconds += 5;
    //   }
    // }
    // int hours = getHoursFromSeconds(totalSeconds);
    // int minutes = getMinutesFromSeconds(totalSeconds) - hours * 60;
    int hours = 1;
    int minutes = 1;
    return "${hours}h ${minutes}m";
  }

  int getHoursFromSeconds(double seconds) {
    return (seconds / 3600).round();
  }

  int getMinutesFromSeconds(double seconds) {
    return (seconds / 60).round();
  }
}
