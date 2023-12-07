import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mixtape/services/friendship_service.dart';

import '../models/friendship.dart';
import '../models/profile.dart';
import '../services/authentication_service.dart';
import '../services/profile_service.dart';
import '../services/services_container.dart';
import '../utilities/navbar_pages.dart';
import '../widgets/navbar.dart';

import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/widgets/navbar.dart';

class SuggestedFriendsPage extends StatefulWidget {
  const SuggestedFriendsPage({Key? key}) : super(key: key);

  @override
  State<SuggestedFriendsPage> createState() => _SuggestedFriendsPageState();
}

class _SuggestedFriendsPageState extends State<SuggestedFriendsPage> {
  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late FriendshipService friendshipService;
  late Future<Profile> currentProfile;
  late Future<List<Profile>> suggestedFriends;
  HashSet<String> suggestedFriendIDs = new HashSet<String>();

  int _selectedIndex = 0;

  void initState() {
    super.initState();

    profileService = ServicesContainer.of(context).profileService;
    authenticationService = ServicesContainer.of(context).authService;
    friendshipService = ServicesContainer.of(context).friendshipService;
    setState(() {
      currentProfile = profileService.getCurrentProfile();
      suggestedFriends = friendshipService.getSuggestedFriendsForCurrentUser();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    String route = "";
    switch (index) {
      case 0:
        route = '/home';
        break;
      case 1:
        route = '/friends';
        break;
      case 2:
        route = "/profile";
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
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Suggested Friends',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: (25.0 * textScaleFactor),
            ),
          ),
        ),
        backgroundColor: MixTapeColors.black,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        toolbarHeight: screenHeight * .13,
      ),
      body: FutureBuilder(
        future: suggestedFriends,
        builder: (context, suggestedFriendsSnapshot) {
          if (suggestedFriendsSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display a loading indicator while waiting for data.
          } else {
            List<Profile> cardData;
            if (!suggestedFriendsSnapshot.hasData) {
              cardData = [];
              suggestedFriendIDs.clear();
            } else {
              cardData = suggestedFriendsSnapshot.data!;
              suggestedFriendIDs.clear();
            }
            return Stack(children: [
              Container(
                height: screenHeight * .67,
                padding: EdgeInsets.fromLTRB(5, 0, 5, 30),
                child: SingleChildScrollView(
                  // Use SingleChildScrollView instead of ListView
                  child: Container(
                    child: Column(
                      children: cardData.map((friend) {
                        suggestedFriendIDs.add(friend.id);
                        return InkWell(
                          borderRadius: BorderRadius.circular(12.0),
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: MixTapeColors.black,
                              //title: const Text('Remove Friend?'),
                              content: const Text(
                                'Would you like to send this user a friend request?',
                                style: TextStyle(
                                  fontSize: (22),
                                  color: Colors.white,
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'CANCEL'),
                                  child: const Text(
                                    'CANCEL',
                                    style: TextStyle(
                                      fontSize: (22),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => {
                                    Navigator.pop(context, 'YES'),
                                    cardData.remove(friend),
                                    friendshipService.createFriendRequest(friend.id),
                                    setState(() {}),
                                  },
                                  child: const Text(
                                    'YES',
                                    style: TextStyle(
                                      fontSize: (22),
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
                                        child: friend.profilePicURL.isNotEmpty
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                friend.displayName,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize:
                                                      (22 * textScaleFactor),
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Card(
                                              color: MixTapeColors.light_gray,
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
            ]);
          }
        },
      ),

      bottomNavigationBar: NavBar(
        friendsPageKey: GlobalKey(),
        context: context,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
