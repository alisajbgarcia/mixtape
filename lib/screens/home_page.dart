import 'package:cached_network_image/cached_network_image.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter/material.dart';
import 'package:mixtape/main.dart';
import 'package:mixtape/screens/playlist_creation.dart';
import 'package:mixtape/screens/playlist_page.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/widgets/navbar.dart';
import 'package:mixtape/screens/notif_page.dart';
import '../models/profile.dart';
import '../models/mixtape.dart';

import '../models/track_info.dart';
import '../services/authentication_service.dart';
import '../services/playlist_service.dart';
import '../services/profile_service.dart';
import '../services/services_container.dart';
import '../tour_targets/home_page_tour_target.dart';
import '../tour_targets/nav_bar_tour_target.dart';
import '../utilities/navbar_pages.dart';
import '../models/playlist.dart';
import '../widgets/welcome_dialog.dart';
import '../widgets/mixtape_premise_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  bool newUser = false;
  late Profile initiatorProfile;

  late TutorialCoachMark homePageTutorialMark;
  late TutorialCoachMark navBarTutorialMark;
  GlobalKey homePageKey = GlobalKey();
  GlobalKey navBarKey = GlobalKey();

  late PlaylistService playlistService;
  late AuthenticationService authenticationService;
  late ProfileService profileService;
  late Future<List<Playlist>> playlists;
  late Future<Profile> currentProfile;
  late List<Reaction> reactions = [Reaction(id: 123, reactor: initiatorProfile, reactionType: ReactionType.LIKE)];

  void homePageTour() {
    homePageTutorialMark = TutorialCoachMark(
      targets: addTourTargets(
          profileKey: homePageKey),
      colorShadow: MixTapeColors.dark_gray,
      paddingFocus: 1,
      hideSkip: true,
      opacityShadow: 0,
      onSkip: () {
        newUser = false;
        return newUser;
      },
      onFinish: () {
        showNavBarTour();
      }
    );
  }

  void navBarTour() {
    navBarTutorialMark = TutorialCoachMark(
      targets: addNavBarTourTargets(
          friendsPageKey: navBarKey),
      colorShadow: MixTapeColors.green,
      paddingFocus: 1,
      hideSkip: false,
      opacityShadow: 0.8,
      onSkip: () {
        return true;
      },
    );
  }

  void showTour() => Future.delayed(Duration(milliseconds: 500),
          () => homePageTutorialMark.show(context: context));

  void showNavBarTour() => Future.delayed(Duration(milliseconds: 500),
          () => navBarTutorialMark.show(context: context));

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    String route = "/home";
    switch (index) {
      case 0:
        return; //don't migrate
      case 1:
        route = "/friends";
        break;
      case 2:
        route = "/profile";
    }
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  void initState(){
    super.initState();

    profileService = ServicesContainer.of(context).profileService;
    playlistService = ServicesContainer.of(context).playlistService;
    authenticationService = ServicesContainer.of(context).authService;
    setState(() {
      currentProfile = profileService.getCurrentProfile();
      playlists = playlistService.getPlaylistsForCurrentUser();
    });

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if(newUser) {
        homePageTour();
        navBarTour();
        openWelcomeDialog();
      }

    });
  }

  void openWelcomeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WelcomeDialog(
          startTutorial: (bool startTutorial) {
            setState(() {
              newUser = startTutorial;
            });
          },
        );
      },
    ).then((result) {
      if (newUser) {
        showTour();
      }
    });
  }

  void openTutorial1() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MixTapePremiseDialog();
      },
    );
  }

  Future<void> _refresh() {
    setState(() {
      currentProfile = profileService.getCurrentProfile();
      playlists = playlistService.getPlaylistsForCurrentUser();
    });
    return Future.delayed(Duration(seconds: 1));
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
        key: homePageKey,
        leading: IconButton(
          padding: EdgeInsets.all(10),
          icon: ImageIcon(
            AssetImage("assets/notif.png"),
            size: textScaleFactor * 50,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/notifs');
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
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
        backgroundColor: MixTapeColors.black,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        toolbarHeight: screenHeight * .13,
        actions: [
          FutureBuilder(
            future: currentProfile,
            builder: (context, profileSnapshot) {
              if (!profileSnapshot.hasData || profileSnapshot.hasError) {
                //return const Center(child: CircularProgressIndicator());
                return Padding(
                  padding: EdgeInsets.all(screenHeight * .03),
                  child: ClipOval(
                    child: Container(
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      child: CircleAvatar(
                        backgroundColor: MixTapeColors.dark_gray,
                        radius: 30,
                        child: Icon(
                          Icons.person,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ),
                );
              }
              final profile = profileSnapshot.data!;
              return Padding(
                padding: EdgeInsets.all(screenHeight * .03),
                child: ClipOval(
                  child: Container(
                    width: screenWidth * 0.15,
                    height: screenWidth * 0.15,
                    child: CachedNetworkImage(
                      imageUrl: profile.profilePicURL,
                      placeholder: (context, url) => CircleAvatar(
                        backgroundColor: MixTapeColors.dark_gray,
                        radius: 30,
                        child: Icon(
                          Icons.person,
                          color: Colors.white70,
                        ),
                      ),
                      errorWidget: (context, url, error) => CircleAvatar(
                        backgroundColor: MixTapeColors.dark_gray,
                        radius: 30,
                        child: Icon(
                          Icons.person,
                          color: Colors.white70,
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }
          )
        ],
      ),
      body: FutureBuilder(
        future: playlists,
        builder: (context, playlistsSnapshot) {
          List<Playlist> cardData;
          if (!playlistsSnapshot.hasData || playlistsSnapshot.hasError) {
            print(playlistsSnapshot.error.toString());
            return const Center(child: CircularProgressIndicator());
            // cardData = dummydata;
            // print('oops');
          } else {
            cardData = playlistsSnapshot.data!;
          }

          // null assert is hella ugly, but the compiler doesn't appear to tell
          // that this won't be null because of the early return
          return Column(
            children: [
              Container(
                height: screenHeight * .67,
                padding: EdgeInsets.fromLTRB(screenWidth * .005, screenWidth * .005, screenWidth * .005, 0),
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  color: MixTapeColors.green,
                  backgroundColor: MixTapeColors.dark_gray,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                        children: cardData.map((playlist) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(12.0),
                            onTap: () {
                              print('Tapped on Card ${playlist.name}');
                              Navigator.of(context).pushNamed(
                                '/playlist', arguments: ScreenArguments(playlist)
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
                                          child: CachedNetworkImage(
                                            imageUrl: playlist.coverPicURL,
                                            placeholder: (context, url) => Image.asset('assets/green_colored_logo.png'),
                                            errorWidget: (context, url, error) => Image.asset('assets/green_colored_logo.png'),
                                          ),
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
                                                child: FutureBuilder(
                                                  future: currentProfile,
                                                  builder: (context, profileSnapshot) {
                                                    if (!profileSnapshot.hasData || profileSnapshot.hasError) {
                                                      return Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Image.asset('assets/green_colored_logo.png',
                                                              width: 25,
                                                              height: 25
                                                          ),
                                                          Text(
                                                            "loading friend",
                                                            style: TextStyle(
                                                              fontSize: (10 * textScaleFactor),
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                    final profile = profileSnapshot.data!;
                                                    return Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      children: [
                                                        if (profile.id == playlist.initiator.id)
                                                          CachedNetworkImage(
                                                              imageUrl: playlist.target.profilePicURL,
                                                              placeholder: (context, url) => Image.asset('assets/green_colored_logo.png'),
                                                              errorWidget: (context, url, error) => Image.asset('assets/green_colored_logo.png'),
                                                              width: 25,
                                                              height: 25
                                                          ),
                                                        if (profile.id == playlist.initiator.id)
                                                          Text(
                                                            "with ${playlist.target.displayName}",
                                                            style: TextStyle(
                                                              fontSize: (10 * textScaleFactor),
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        if (profile.id == playlist.target.id)
                                                          CachedNetworkImage(
                                                              imageUrl: playlist.initiator.profilePicURL,
                                                              placeholder: (context, url) => Image.asset('assets/green_colored_logo.png'),
                                                              errorWidget: (context, url, error) => Image.asset('assets/green_colored_logo.png'),
                                                              width: 25,
                                                              height: 25
                                                          ),
                                                        if (profile.id == playlist.target.id)
                                                          Text(
                                                            "with ${playlist.initiator.displayName}",
                                                            style: TextStyle(
                                                              fontSize: (10 * textScaleFactor),
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                      ],
                                                    );
                                                  },
                                                )

                                              ),
                                              Card(
                                                color: MixTapeColors.light_gray,
                                                elevation: 0.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${playlist.songCount} songs",
                                                      style: TextStyle(
                                                        fontSize: (12 * textScaleFactor),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${getTotalTimeHHMM(playlist.totalDurationMS)}',
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
              Navigator.of(context).pushNamed(
                '/playlistcreate'
              );
            },
            label: Text(
                'Create a Playlist',
                style: TextStyle(
                  fontSize: textScaleFactor * 20,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
            ),
            icon: Icon(
                Icons.add,
                color: Colors.white
            ),
            backgroundColor: MixTapeColors.green, // Change the button's color
          ),
      ),
      bottomNavigationBar: NavBar(
        friendsPageKey: navBarKey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        context: context,
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