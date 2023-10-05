import 'package:flutter/material.dart';
import 'package:mixtape/screens/playlist_creation.dart';
import 'package:mixtape/screens/playlist_screen.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/widgets/navbar.dart';
import 'package:mixtape/screens/notif_page.dart';

import '../utilities/navbar_pages.dart';
import '../models/PlaylistInfo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  bool light = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NavbarPages.navBarPages.elementAt(_selectedIndex)),
    );
  }

  List<PlaylistInfo> cardData = [
    PlaylistInfo('ish and charlie like to party', 'assets/green_colored_logo.png', 20, 'cmsale', 'assets/blue_colored_logo.png', 3, 27),
    PlaylistInfo('group running playlist', 'assets/blue_colored_logo.png', 30, 'alexfrey2', 'assets/alex_profile_picture.png', 5, 42),
    PlaylistInfo('trombone tunes', 'assets/red_colored_logo.png', 50, 'scoobydrew', 'assets/red_colored_logo.png', 1, 17),
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
        leading: IconButton(
          padding: EdgeInsets.all(10),
          icon: ImageIcon(
            AssetImage("assets/notif.png"),
            size: textScaleFactor * 50
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotifPage()),
            );
          }
          ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0,5,0,0),
              child: Text('Your Playlists',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: (25.0 * textScaleFactor),
                ),
              ),
            ),
            Row(
              children: [
                /*
                Icon(
                  light ? Icons.sunny : Icons.dark_mode,
                  color: Colors.white,
                ),
                Switch(
                  // This bool value toggles the switch.
                  value: light,
                  activeColor: MixTapeColors.green,
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    setState(() {
                      light = value;
                    });
                  },
                ),
                */
              ],
            ),
            ],
        ),
        backgroundColor: MixTapeColors.black,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        toolbarHeight: screenHeight * .13,
        actions: [
          Padding(
            padding: EdgeInsets.all(screenHeight * .03),
            child: Image.asset('assets/ish_profile_picture.png'),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight * .67,
            padding: EdgeInsets.fromLTRB(5, 10, 5, 30),
            child: SingleChildScrollView(
              child: Column(
                  children: cardData.map((playlist) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () {
                        print('Tapped on Card ${playlist.title}');
                        print(playlist.title);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PlaylistScreen(playlist: playlist)),
                        );
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                          ),
                          elevation: 3.0,
                          margin: EdgeInsets.all(10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: screenHeight * .17,
                                    color: MixTapeColors.dark_gray,
                                    child: Image.asset(playlist.image),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
                                    height: screenHeight * .17,
                                    color: MixTapeColors.light_gray,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: screenHeight * 0.06, // Limit the text height
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown, // Text will automatically resize to fit the available space
                                            child: Text(
                                              playlist.title,
                                              textAlign: TextAlign.center,
                                              maxLines: 2, // Set the maximum number of lines to display
                                              overflow: TextOverflow.ellipsis, // Truncate text with ellipsis if it overflows
                                              style: TextStyle(
                                                fontSize: (22 * textScaleFactor),
                                                color: Colors.white,
                                              ),
                                            ),
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
                                              Image.asset(playlist.friendProfile, width: 25, height: 25),
                                              Text(
                                                "with ${playlist.friend}",
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
                                                '${playlist.hours} hours, ${playlist.minutes} min',
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
        ],
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(top: 10, bottom: 5, left: 30, right: 10),
        child: FloatingActionButton.extended(
            heroTag: "playlist_creation",
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
            ),
            onPressed: () {
              print("here omg please");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlaylistCreationScreen()),
              );
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
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}