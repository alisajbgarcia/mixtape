import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mixtape/services/friendship_service.dart';

import '../models/friendship.dart';
import '../models/profile.dart';
import '../models/settings.dart';
import '../services/authentication_service.dart';
import '../services/profile_service.dart';
import '../services/services_container.dart';
import '../utilities/navbar_pages.dart';
import '../widgets/navbar.dart';

import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/widgets/navbar.dart';

import 'friend_info_page.dart';

class ApprovedFriendsPage extends StatefulWidget {
  const ApprovedFriendsPage({Key? key}) : super(key: key);

  @override
  State<ApprovedFriendsPage> createState() => _ApprovedFriendsPageState();
}

class FriendsInfo {
  String username;
  String image;

  FriendsInfo(this.username, this.image);
}

class _ApprovedFriendsPageState extends State<ApprovedFriendsPage> {
  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late Future<Profile> currentProfile;
  late Future<List<Profile>> friends;
  late List<Profile> test;
  late Future<Settings> profileSettings;
  HashSet<String> friendIDs = new HashSet<String>();

  bool isAddApprovedFriendsVisible = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    profileService = ServicesContainer.of(context).profileService;
    setState(() {
      currentProfile = profileService.getCurrentProfile();
      friends = profileService.getFriendsForCurrentUser();
      profileSettings = profileService.getProfileSettings();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              NavbarPages.navBarPages.elementAt(_selectedIndex)),
    );
  }

  void toggleAddFriends() {
    setState(() {
      isAddApprovedFriendsVisible = !isAddApprovedFriendsVisible;
    });
  }

  List<Profile> dummydata = [
    Profile('zestythomae', 'andrew thomae', 'spotifyuid',
        'assets/green_colored_logo.png'),
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
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Approved Friends',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: (25.0 * textScaleFactor),
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
          future: profileSettings,
          builder: (context, settingsSnapshot) {
            if (settingsSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Display a loading indicator while waiting for data.
            } else {
              Settings settings;
              List<Profile> cardData;
              if (!settingsSnapshot.hasData) {
                cardData = [];
                friendIDs.clear();
              } else {
                settings = settingsSnapshot.data!;
                cardData = settings.friendsWithPermission;
                friendIDs.clear();
              }
              return Stack(
                children: [
                  Container(
                    height: screenHeight * .67,
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 30),
                    child: SingleChildScrollView(
                      // Use SingleChildScrollView instead of ListView
                      child: Container(
                        child: Column(
                          children: cardData.map((friend) {
                            friendIDs.add(friend.id);
                            return InkWell(
                              borderRadius: BorderRadius.circular(12.0),
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
                                            child: friend
                                                    .profilePicURL.isNotEmpty
                                                ? Image.network(
                                                    friend.profilePicURL)
                                                : Container(
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
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                bottom: 5,
                                                left: 10,
                                                right: 10),
                                            height: screenHeight * .07,
                                            color: MixTapeColors.light_gray,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
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
                                                  color:
                                                      MixTapeColors.light_gray,
                                                  elevation: 0.0,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  isAddApprovedFriendsVisible
                      ? Container(
                          color: MixTapeColors.dark_gray,
                          height: MediaQuery.of(context).size.height * 3 / 4,
                          child: Center(
                              child: isAddApprovedFriendsVisible
                                  ? Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  MixTapeColors.light_gray,
                                              shape: CircleBorder(
                                                side: BorderSide(
                                                    color: MixTapeColors
                                                        .light_gray),
                                              ),
                                            ),
                                            child: Text(
                                              style: TextStyle(
                                                fontSize:
                                                    (15 * textScaleFactor),
                                                color: Colors.white,
                                              ),
                                              'X',
                                            ),
                                            onPressed: toggleAddFriends,
                                          ),
                                        ),
                                        FutureBuilder(
                                            future: currentProfile,
                                            builder:
                                                (context, profileSnapshot) {
                                              if (!profileSnapshot.hasData ||
                                                  profileSnapshot.hasError) {
                                                return CircularProgressIndicator(); // Display a loading indicator while waiting for data.
                                              }
                                              Profile profile =
                                                  profileSnapshot.data!;
                                              return FutureBuilder(
                                                  future: friends,
                                                  builder: (context,
                                                      friendsSnapshot) {
                                                    if (friendsSnapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return CircularProgressIndicator(); // Display a loading indicator while waiting for data.
                                                    }
                                                    List<Profile>
                                                        addFriendCardData;
                                                    if (!friendsSnapshot
                                                        .hasData) {
                                                      addFriendCardData = [];
                                                    } else {
                                                      addFriendCardData =
                                                          friendsSnapshot.data!;
                                                    }
                                                    print(
                                                        "add friend card data");
                                                    print(addFriendCardData);

                                                    return Container(
                                                        child: Column(
                                                      children:
                                                          addFriendCardData
                                                              .map((friend) {
                                                        if (profile.id !=
                                                                friend.id &&
                                                            !friendIDs.contains(
                                                                friend.id)) {
                                                          return InkWell(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                            onTap: () {
                                                              print(
                                                                  'Add Friend Tapped: ${friend.displayName}');
                                                            },
                                                            child: Card(
                                                                color: MixTapeColors
                                                                    .light_gray,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0), // Adjust the radius as needed
                                                                ),
                                                                elevation: 3.0,
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            2.0),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.all(6),
                                                                          height:
                                                                              screenHeight * .07,
                                                                          color:
                                                                              MixTapeColors.dark_gray,
                                                                          child: friend.profilePicURL.isNotEmpty
                                                                              ? Image.network(friend.profilePicURL)
                                                                              : Container(
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
                                                                        child:
                                                                            Container(
                                                                          padding: EdgeInsets.only(
                                                                              top: 10,
                                                                              bottom: 5,
                                                                              left: 10,
                                                                              right: 10),
                                                                          height:
                                                                              screenHeight * .07,
                                                                          color:
                                                                              MixTapeColors.light_gray,
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  friend.displayName,
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(
                                                                                    fontSize: (22 * textScaleFactor),
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Card(
                                                                                color: MixTapeColors.light_gray,
                                                                                elevation: 0.0,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                          color:
                                                                              MixTapeColors.light_gray,
                                                                          child: TextButton(
                                                                              child: Text(
                                                                                '+',
                                                                                style: TextStyle(
                                                                                  fontSize: (22 * textScaleFactor),
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              onPressed: () async {
                                                                                try {
                                                                                  await profileService.addApprovedFriend(friend.id);
                                                                                  final snackBar = SnackBar(content: Text('Added ${friend.displayName} to approved friends list'));
                                                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                } catch (err) {
                                                                                  print(err);
                                                                                  final snackBar = SnackBar(content: Text('Error in sending friend request to ${friend.displayName}'));
                                                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                                                }
                                                                              }))
                                                                    ],
                                                                  ),
                                                                )),
                                                          );
                                                        } else {
                                                          return SizedBox
                                                              .shrink();
                                                        }
                                                      }).toList(),
                                                    ));
                                                  });
                                            })

                                        //TODO: Search bar results
                                      ],
                                    )
                                  : SizedBox() // Empty placeholder when not visible
                              ),
                        )
                      : Container(
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              print('Tapped Added Friends');
                            },
                            child: Container(
                              //alignment: Alignment.bottomRight,
                              width: 200,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: MixTapeColors.green,
                              ),
                              child: Center(
                                  child: TextButton(
                                child: Text(
                                  'Add Approved Friends +',
                                  style: TextStyle(
                                    fontSize: (22 * textScaleFactor),
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: toggleAddFriends,
                              )),
                            ),
                          ),
                        ),
                ],
              );
            }
          }),
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
