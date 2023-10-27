import 'package:flutter/material.dart';
import 'package:mixtape/screens/playlist_creation.dart';
import 'package:mixtape/screens/playlist_screen.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/widgets/navbar.dart';
import 'package:mixtape/screens/notif_page.dart';
import '../models/profile.dart';
import '../models/mixtape.dart';

import '../models/track_info.dart';
import '../services/authentication_service.dart';
import '../services/profile_service.dart';
import '../services/services_container.dart';
import '../utilities/navbar_pages.dart';
import '../models/playlist.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  bool light = true;
  late Profile exampleProfile;
  late List<String> songIds;
  late Mixtape sampleMixtape;
  late List<Mixtape> mixtapes;
  late List<Playlist> cardData;
  late List<TrackInfo> tracks;

  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late Future<Profile> currentProfile;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NavbarPages.navBarPages.elementAt(_selectedIndex)),
    );
  }

  @override
  void initState(){
    super.initState();
    exampleProfile = Profile('id', 'cmsale', 'spotifyId', 'assets/blue_colored_logo.png');
    songIds = ['id', 'id', 'id'];
    DateTime date = DateTime.now();
    sampleMixtape = Mixtape(id: 'id', playlistID: 'playlistId', name: 'name', createdAt: date, description: 'description', creator: exampleProfile, songIDs: songIds, songs: tracks);
    mixtapes = [sampleMixtape, sampleMixtape];
    cardData = [
      Playlist(id: 'ID', spotifyID: 'spotifyID', name: 'ish and charlie like to party', initiator: exampleProfile, target: exampleProfile, description: 'description', coverPicURL: 'assets/blue_colored_logo.png', mixtapes: mixtapes),
    ];

    profileService = ServicesContainer.of(context).profileService;
    authenticationService = ServicesContainer.of(context).authService;
    setState(() {
      currentProfile = profileService.getCurrentProfile();
    });
  }

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
      body: FutureBuilder(
        future: currentProfile,
        builder: (context, profileSnapshot) {
          if (!profileSnapshot.hasData || profileSnapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }

          // null assert is hella ugly, but the compiler doesn't appear to tell
          // that this won't be null because of the early return
          final profile = profileSnapshot.data!;
          return Column(
            children: [
              Container(
                height: screenHeight * .67,
                padding: EdgeInsets.fromLTRB(screenWidth * .005, screenWidth * .005, screenWidth * .005, 0),
                child: SingleChildScrollView(
                  child: Column(
                      children: cardData.map((playlist) {
                        return InkWell(
                          borderRadius: BorderRadius.circular(12.0),
                          onTap: () {
                            print('Tapped on Card ${playlist.name}');
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
                              margin: EdgeInsets.all(screenWidth * .03),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.all(screenWidth * .005),
                                        height: screenHeight * .17,
                                        color: MixTapeColors.dark_gray,
                                        child: Image.asset(playlist.coverPicURL),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.only(top: screenWidth * .01, bottom: screenWidth * .005, left: screenWidth * .01, right: screenWidth * .01),
                                        height: screenHeight * .17,
                                        color: MixTapeColors.light_gray,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(screenWidth * .015),
                                              height: screenHeight * .035,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  playlist.name,
                                                  textAlign: TextAlign.center,
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
                                                  Image.asset(playlist.coverPicURL, width: 25, height: 25),
                                                  Text(
                                                    "with ${playlist.initiator.displayName}",
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
                                                    "${10} songs",
                                                    style: TextStyle(
                                                      fontSize: (12 * textScaleFactor),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${2} hours, ${32} min',
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
          );
        }
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