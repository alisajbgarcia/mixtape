import 'package:flutter/material.dart';
import 'package:mixtape/screens/tape_creation.dart';
import 'package:mixtape/screens/tape_info_screen.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/screens/search_page.dart';
import '../models/mixtape.dart';
import '../models/playlist.dart';
import '../models/profile.dart';
import '../models/track_info.dart';

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
  late List<Mixtape> cardData;
  late Profile exampleProfile;
  late DateTime createdAt;
  late List<String> songIds;

  @override
  void initState() {
    super.initState();

    exampleProfile = Profile('id', 'cmsale', 'spotifyId', 'https://i.scdn.co/image/ab67757000003b8262187a7fae1ceff7d4078e5e');
    createdAt = DateTime.now();
    songIds = ['id', 'id', 'id'];

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

    songs = tameImpala;

    // Initialize cardData
    cardData = [
       Mixtape(id: 'id', playlistID: 'playlistId', name: 'name', createdAt: createdAt, description: 'description', creator: exampleProfile, songIDs: songIds, songs: songs),
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
                            "${widget.playlist.songCount} songs, ${getTotalTimeHHMM(widget.playlist.totalDurationMS)}",
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
                  left: screenWidth * .04,
                  top: screenHeight * .25, // Adjust the top position as needed
                  //child: Text(widget.playlist.target.displayName, style: TextStyle(color: Colors.white)),
                  child: Image.network(widget.playlist.initiator.profilePicURL, width: screenHeight * .06, height: screenHeight * .06),
                ),
                Positioned(
                  left: screenWidth * .75,
                  right: 0,
                  top: screenHeight * .25, // Adjust the top position as needed
                  //child: Text('here', style: TextStyle(color: Colors.white)),
                  child: Image.network(widget.playlist.initiator.profilePicURL, width: screenHeight * .06, height: screenHeight * .06),
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
                          MaterialPageRoute(builder: (context) => TapeInfoScreen(tape_id: 1, spotify_id: 2, title: mixtape.name, image: 'assets/blue_colored_logo.png', songs: mixtape.songs, description: mixtape.description,)),
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
                                        'assets/blue_colored_logo.png',
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
                                        'assets/blue_colored_logo.png',
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
      ),
    );
  }

  String getTotalTimeHHMM(int totalDurationMS) {
    int hours = getHoursFromMS(totalDurationMS);
    int minutes = getMinutesFromMS(totalDurationMS) - hours * 60;
    return "${hours}h ${minutes}m";
  }

  int getHoursFromMS(int milliseconds) {
    return (milliseconds / 3600000).truncate();
  }

  int getMinutesFromMS(int milliseconds) {
    return (milliseconds / 60000).truncate();
  }
}
