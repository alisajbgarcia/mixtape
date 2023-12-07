import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mixtape/models/profile.dart';
import 'package:mixtape/screens/home_page.dart';
import 'package:mixtape/screens/login_page.dart';
import 'package:mixtape/screens/settings_page.dart';
import 'package:mixtape/services/authentication_service.dart';
import 'package:mixtape/services/profile_service.dart';
import 'package:mixtape/services/services_container.dart';
import 'package:mixtape/utilities/navbar_pages.dart';
import 'package:mixtape/widgets/navbar.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../utilities/colors.dart';
import 'package:mixtape/tour_targets/profile_tour_target.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late Future<Profile> currentProfile;
  late TutorialCoachMark tutorialCoachMark;
  late bool playlists_enabled;

  GlobalKey profilePageSettingsKey = GlobalKey();

  GlobalKey profileKey = GlobalKey();

  void pageTour() {
    tutorialCoachMark = TutorialCoachMark(
      targets: addTourTargets(
          profileKey: profileKey),
      colorShadow: MixTapeColors.green,
      paddingFocus: 10,
      textSkip: "NEXT",
      opacityShadow: 0.8,
      onSkip: () {
        Navigator.of(context).pop();
        return true;
      },
    );
  }

  void showTour() => Future.delayed(Duration(seconds: 1),
      () => tutorialCoachMark.show(context: context));

  @override
  void initState() {
    super.initState();
    profileService = ServicesContainer.of(context).profileService;
    authenticationService = ServicesContainer.of(context).authService;
    setState(() {
      currentProfile = profileService.getCurrentProfile();
      // TODO: initialize playlists enabled value to backend value
      playlists_enabled = false;
    });


  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    String route = "/friends";
    switch (index) {
      case 0:
        route = '/home';
        break;
      case 1:
        route = '/friends';
        break;
      case 2:
        return; //don't migrate
    }
    Navigator.of(context).pushReplacementNamed(route);
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
        backgroundColor: MixTapeColors.black,
        key: profilePageSettingsKey,
        // leading: IconButton(
        //   padding: EdgeInsets.all(10),
        //   icon: Icon(
        //     Icons.settings,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     print("settings");
        //     // Navigator.push(
        //     //   context,
        //     //   MaterialPageRoute(builder: (context) => SettingsPage()),
        //     // );
        //   }
        // ),
        // title: Text(
        //   'Profile',
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontFamily: 'Montserrat',
        //     fontWeight: FontWeight.bold,
        //     fontSize: 40.0 * textScaleFactor,
        //   ),
        // ),
        actions: [ IconButton(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * .03),
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: MediaQuery.of(context).size.width * .1,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            }
        ),]
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * .01),
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0 * textScaleFactor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, screenHeight * .02, 0, screenHeight * .03),
                      child: ClipOval(// Adjust the fit as needed
                        child: CachedNetworkImage(
                          width: screenHeight * .2,
                          height: screenHeight * .2,
                          // fit: BoxFit.cover, // Adjust the fit as needed
                          imageUrl: profile.profilePicURL,
                          placeholder: (context, url) => CircleAvatar(
                            backgroundColor: MixTapeColors.dark_gray,
                            radius: 30,
                            child: Icon(
                              Icons.person,
                              color: Colors.white70,
                              size: MediaQuery.of(context).size.width * .3,
                            ),
                          ),
                          errorWidget: (context, url, error) => CircleAvatar(
                            backgroundColor: MixTapeColors.dark_gray,
                            radius: 30,
                            child: Icon(
                              Icons.person,
                              color: Colors.white70,
                              size: MediaQuery.of(context).size.width * .25,
                            ),
                          ),
                          fit: BoxFit.cover,
                        ),
                        // child: Image.network(
                        //   key: profileKey,
                        //   profile.profilePicURL,
                        //   width: screenHeight * .15,
                        //   height: screenHeight * .15,
                        //   fit: BoxFit.cover, // Adjust the fit as needed
                        // ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * .01),
                      child: Text(
                        profile.displayName,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0 * textScaleFactor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Flexible(
              //   flex: 1,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       // Padding(
              //       //   padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * .015),
              //       //   child: Switch(
              //       //   // This bool value toggles the switch.
              //       //   value: playlists_enabled,
              //       //   activeColor: MixTapeColors.green,
              //       //   inactiveTrackColor: MixTapeColors.light_gray,
              //       //   onChanged: (bool value) {
              //       //     // This is called when the user toggles the switch.
              //       //     setState(() {
              //       //       playlists_enabled = value;
              //       //     });
              //       //   },
              //       // ), ),
              //       // Text("Require Approval For Playlists",
              //       //   style: TextStyle(
              //       //   color: Colors.white,
              //       //   fontFamily: 'Montserrat',
              //       //   fontWeight: FontWeight.bold,
              //       //   fontSize: 15.0 * textScaleFactor,
              //       // ),)
              //     ]
              //   )
              // ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .1,
                    right: MediaQuery.of(context).size.width * .1,
                    top: MediaQuery.of(context).size.height * .05,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      fixedSize: MaterialStateProperty.all(Size.fromHeight(
                          MediaQuery.of(context).size.height * .12)),
                      padding: MaterialStateProperty.all(EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .05,
                          right: MediaQuery.of(context).size.width * .05)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                    ),
                    onPressed: () {
                      print("logout");
                      showAlertDialog(context, textScaleFactor);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Image.asset(
                            'assets/spotify/Spotify_Icon_RGB_Green.png',
                            width: 50,
                            height: 100,
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Center(
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20.0 * textScaleFactor,
                                fontWeight: FontWeight.bold,
                                color: MixTapeColors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
      bottomNavigationBar: NavBar(
        friendsPageKey: GlobalKey(),
        context: context,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  handleLogout(void Function() onComplete, {void Function(Object)? onError}) {
    authenticationService.logout()
        .then((value) => onComplete(), onError: onError);
  }

  showAlertDialog(BuildContext context, double textScaleFactor) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
          "Cancel",
        style: TextStyle(color: MixTapeColors.green, fontSize: textScaleFactor * 16)
      ),
      onPressed:  () {
        Navigator.pop(context, 'Cancel');
      },
    );
    Widget continueButton = TextButton(
      child: Text("Logout",
          style: TextStyle(color: MixTapeColors.green, fontSize: textScaleFactor * 16)
    ),
      onPressed:  () {
        handleLogout(() {
          const snackBar = SnackBar(
            content: Text('Successfully Logged Out'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.of(context).pushReplacementNamed('/');
        }, onError: (err) {
          const snackBar = SnackBar(
            content: Text('Failed to log out'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: MixTapeColors.dark_gray,
      title: Text("Are you sure you would like to log out?",
      style: TextStyle(color: Colors.white, fontSize: textScaleFactor * 20)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
