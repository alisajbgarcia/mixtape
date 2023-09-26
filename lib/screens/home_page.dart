import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/widgets/navbar.dart';

import '../utilities/navbar_pages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class PlaylistInfo {
  String title;
  String image;
  int numSongs;

  PlaylistInfo(this.title, this.image, this.numSongs);
}


class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NavbarPages.navBarPages.elementAt(_selectedIndex)),
    );
  }

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
      backgroundColor: MixTapeColors.black,
      appBar: AppBar(
        title: Text('Your Playlists',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: (25.0 * textScaleFactor),
          ),
        ),
        backgroundColor: MixTapeColors.black,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        toolbarHeight: screenHeight * .13,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/blue_colored_logo.png'),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight * .67,
            padding: EdgeInsets.fromLTRB(5, 0, 5, 30),
            child: SingleChildScrollView( // Use SingleChildScrollView instead of ListView
              child: Container(
                child: Column(
                  children: cardData.map((playlist) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () {
                        print('Tapped on Card ${playlist.title}');
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
          ),
          FloatingActionButton.extended(
            onPressed: () {
              // Add your button action here
            },
            label: Text(
                'Create a Playlist',
                style: TextStyle(
                  fontSize: textScaleFactor * 20,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                ),
            ),
            icon: Icon(Icons.add),
            backgroundColor: MixTapeColors.green, // Change the button's color
          ),
        ],
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}