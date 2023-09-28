import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

class PlaylistInfo {
  String title;
  String image;
  int numSongs;

  PlaylistInfo(this.title, this.image, this.numSongs);
}

class PlaylistScreen extends StatefulWidget {
  final int playlistId;
  final int spotify_id;
  const PlaylistScreen({required this.playlistId, required this.spotify_id});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {

  // API call to get playlist info
  List<PlaylistInfo> cardData = [
    PlaylistInfo('ish and charlie like to party', 'assets/green_colored_logo.png', 20),
    PlaylistInfo('group running playlist', 'assets/blue_colored_logo.png', 30),
    PlaylistInfo('trombone tunes', 'assets/red_colored_logo.png', 50),
  ];

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
                            'ish and charlie like to party',
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
                    top: screenHeight * .27,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(screenWidth * .05, 0, 0, 0),
                            child: Container(
                              decoration: ShapeDecoration(
                                color: MixTapeColors.light_gray,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.add_photo_alternate_outlined),
                                color: Colors.white,
                                onPressed: () {
                                  print("here my goodness");
                                },
                              ),
                            ),
                          ),
                        ),

                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, screenWidth * .05, 0),
                            child: IconButton(
                              icon: Icon(
                                Icons.person_add_alt_rounded,
                                size: screenHeight * .04,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                print("do you have friends");
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView( // Use SingleChildScrollView instead of ListView
                child: Column(
                  children: cardData.map((playlist) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () {
                        print('Tapped on Card ${playlist.title}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PlaylistScreen(playlistId: 1, spotify_id: 2)),
                        );
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                          ),
                          elevation: 3.0,
                          margin: EdgeInsets.all(15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: screenHeight * .2,
                                    color: MixTapeColors.dark_gray,
                                    child: Image.asset(playlist.image),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
                                    height: screenHeight * .2,
                                    color: MixTapeColors.light_gray,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          playlist.title,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: (22 * textScaleFactor),
                                            color: Colors.white,
                                          ),
                                        ),
                                        FilledButton(
                                          style: FilledButton.styleFrom(
                                            backgroundColor: MixTapeColors.dark_gray,
                                            padding: EdgeInsets.all(0),
                                            fixedSize: Size(150, 15),
                                          ),
                                          onPressed: null,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Image.asset('assets/blue_colored_logo.png', width: 25, height: 25),
                                              Text(
                                                "with alexfrey2",
                                                style: TextStyle(
                                                  fontSize: (10 * textScaleFactor),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Card(
                                          color: MixTapeColors.light_gray,
                                          elevation: 0.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${playlist.numSongs} songs",
                                                style: TextStyle(
                                                  fontSize: (12 * textScaleFactor),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                '${3} hours, ${30} min',
                                                style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: (12 * textScaleFactor),
                                                ),
                                              ),
                                              Image.asset(
                                                'assets/spotify/Spotify_Icon_RGB_Green.png',
                                                height: screenHeight * .03,
                                                width: screenHeight * .03,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlaylistCreationScreen()),
                  ); */
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
}
