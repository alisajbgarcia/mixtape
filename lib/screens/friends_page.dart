import 'package:flutter/material.dart';

import '../models/profile.dart';
import '../services/authentication_service.dart';
import '../services/profile_service.dart';
import '../services/services_container.dart';
import '../utilities/navbar_pages.dart';
import '../widgets/navbar.dart';

import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/widgets/navbar.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class FriendsInfo {
  String username;
  String image;

  FriendsInfo(this.username, this.image);
}

class _FriendsPageState extends State<FriendsPage> {
  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late Future<Profile> currentProfile;
  late Future<List<Profile>> friends;
  late List<Profile> test;

  bool isSearchBarVisible = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    profileService = ServicesContainer.of(context).profileService;
    authenticationService = ServicesContainer.of(context).authService;
    setState(() {
      currentProfile = profileService.getCurrentProfile();
      friends = profileService.getFriendsForCurrentUser();
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

  void toggleSearchBar() {
      setState(() {
        isSearchBarVisible = !isSearchBarVisible;
      });
    }

  List<Profile> dummydata = [
    Profile('zestythomae', 'andrew thomae', 'spotifyuid', 'assets/green_colored_logo.png'),
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
          child: Text('Your Friends',
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
        future: friends,
        builder: (context, friendsSnapshot) {
          if (friendsSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display a loading indicator while waiting for data.
          } else {
            List<Profile>? cardData = friendsSnapshot.data;
            if(cardData == null) {
              cardData = dummydata;
            }
            return Stack(
              children: [
                Container(
                  height: screenHeight * .67,
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 30),
                  child: SingleChildScrollView( // Use SingleChildScrollView instead of ListView
                    child: Container(
                      child: Column(
                        children: cardData.map((friend) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(12.0),
                            onTap: () {
                              print('Tapped on Friend ${friend.displayName}');
                            },
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
                                          child: Image.asset(friend.profilePicURL),
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
                isSearchBarVisible
                    ? Container(
                  color: MixTapeColors.dark_gray,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 3 / 4,
                  child: Center(
                      child: isSearchBarVisible
                          ? Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: MixTapeColors.light_gray,
                                shape: CircleBorder(
                                  side: BorderSide(
                                      color: MixTapeColors.light_gray),
                                ),
                              ),
                              child: Text(
                                style: TextStyle(
                                  fontSize: (15 * textScaleFactor),
                                  color: Colors.white,
                                ),
                                'X',
                              ),
                              onPressed: toggleSearchBar,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: 0, bottom: 5, left: 10, right: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                filled: true,
                                hintStyle: TextStyle(
                                    color: MixTapeColors.dark_gray),
                                hintText: "Search for users...",
                                fillColor: Colors.white70,
                              ),
                            ),
                          ),
                          //TODO: Search bar results
                          Container(
                              child: Column(
                                children: cardData.map((friend) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(12.0),
                                    onTap: () {
                                      print(
                                          'Search Friend Tapped: ${friend
                                              .displayName}');
                                    },
                                    child: Card(
                                        color: MixTapeColors.light_gray,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              12.0), // Adjust the radius as needed
                                        ),
                                        elevation: 3.0,
                                        margin: EdgeInsets.all(2.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              12.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  height: screenHeight * .07,
                                                  color: MixTapeColors
                                                      .dark_gray,
                                                  child: Image.asset(
                                                      friend.profilePicURL),
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
                                                  color: MixTapeColors
                                                      .light_gray,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .center,
                                                        child: Text(
                                                          friend.displayName,
                                                          textAlign: TextAlign
                                                              .center,
                                                          style: TextStyle(
                                                            fontSize: (22 *
                                                                textScaleFactor),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Card(
                                                        color: MixTapeColors
                                                            .light_gray,
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
                                              Container(
                                                  color: MixTapeColors
                                                      .light_gray,
                                                  child: TextButton(
                                                      child: Text(
                                                        '+',
                                                        style: TextStyle(
                                                          fontSize: (22 *
                                                              textScaleFactor),
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        final snackBar = SnackBar(
                                                            content: Text(
                                                                'Friend request sent to: ${friend
                                                                    .displayName}')

                                                        );
                                                        ScaffoldMessenger.of(
                                                            context)
                                                            .showSnackBar(
                                                            snackBar);
                                                      }
                                                  )
                                              )
                                            ],
                                          ),
                                        )
                                    ),
                                  );
                                }).toList(),
                              )
                          ),
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
                              'Add Friends +',
                              style: TextStyle(
                                fontSize: (22 * textScaleFactor),
                                color: Colors.white,
                              ),
                            ),
                            onPressed: toggleSearchBar,
                          )
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        }
      ),

      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
