import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import '../models/profile.dart';
import '../services/authentication_service.dart';
import '../services/friendship_service.dart';
import '../services/profile_service.dart';
import '../services/services_container.dart';
import 'friend_info_page.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class FriendsInfo {
  String username;
  String image;

  FriendsInfo(this.username, this.image);
}

class _SettingsPageState extends State<SettingsPage> {
  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late FriendshipService friendshipService;
  late Future<Profile> currentProfile;
  late Future<List<Profile>> friends;
  late List<Profile> test;
  late Future<List<Profile>> searchFriends;
  HashSet<String> friendIDs = HashSet<String>();
  late bool playlists_enabled;

  bool isSearchBarVisible = false;

  @override
  void initState() {
    super.initState();

    profileService = ServicesContainer.of(context).profileService;
    authenticationService = ServicesContainer.of(context).authService;
    friendshipService = ServicesContainer.of(context).friendshipService;
    setState(() {
      currentProfile = profileService.getCurrentProfile();
      friends = profileService.getBlockedProfilesForCurrentUser();
      searchFriends = profileService.searchProfiles("");
      playlists_enabled = true;
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
        title: Align(
          alignment: Alignment.center,
          child: Text('Settings',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: (30.0 * textScaleFactor),
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: MixTapeColors.black,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        toolbarHeight: screenHeight * .13,
      ),

      body: FutureBuilder(
          future: friends,
          builder: (context, friendsSnapshot) {
            if (friendsSnapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Display a loading indicator while waiting for data.
            } else {
              List<Profile> cardData;
              if(!friendsSnapshot.hasData) {
                cardData = [];
                friendIDs.clear();
              } else {
                cardData = friendsSnapshot.data!;
                friendIDs.clear();
              }
              return Column(
                children: [
                  Container(
                      margin: EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Require Approval For Playlists",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0 * textScaleFactor,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .015),
                              child: Switch(
                                // This bool value toggles the switch.
                                value: playlists_enabled,
                                activeColor: MixTapeColors.green,
                                inactiveTrackColor: MixTapeColors.light_gray,
                                onChanged: (bool value) {
                                  // This is called when the user toggles the switch.
                                  setState(() {
                                    playlists_enabled = value;
                                  });
                                },
                              ), ),
                          ]
                      )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text('Blocked Users',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: (20.0 * textScaleFactor),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 30),
                    child: SingleChildScrollView( // Use SingleChildScrollView instead of ListView
                      child: Container(
                        child: Column(
                          children: cardData.map((friend) {
                            friendIDs.add(friend.id);
                            return InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  backgroundColor: MixTapeColors.black,
                                  //title: const Text('Remove Friend?'),
                                  content: const Text(
                                    'Would you like to unblock this user?',
                                    style: TextStyle(
                                      fontSize: (22),
                                      color: Colors.white,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'CANCEL'),
                                      child: const Text(
                                        'CANCEL',
                                        style: TextStyle(
                                          fontSize: (18),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => {
                                        Navigator.pop(context, 'UNBLOCK'),
                                        friendshipService.unblockUser(friend.id),
                                        setState(() {}),
                                      },
                                      child: const Text(
                                        'UNBLOCK',
                                        style: TextStyle(
                                          fontSize: (18),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12.0), // Adjust the radius as needed
                                ),
                                elevation: 3.0,
                                margin: EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          height: screenHeight * .07,
                                          color: MixTapeColors.dark_gray,
                                          child: friend.profilePicURL.isNotEmpty ?
                                          Image.network(friend.profilePicURL) :
                                          Container(
                                            child: Icon(
                                              Icons.person_2_rounded,
                                              color: Colors.white70,
                                              size: screenWidth * .1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: EdgeInsets.only(top: 10,
                                            bottom: 5,
                                            left: 10,
                                            right: 10),
                                          height: screenHeight * .07,
                                          color: MixTapeColors.light_gray,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  friend.displayName,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: (22 *
                                                        textScaleFactor),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                color: MixTapeColors.light_gray,
                                                elevation: 0.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
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
          }
      ),
    );
  }
}