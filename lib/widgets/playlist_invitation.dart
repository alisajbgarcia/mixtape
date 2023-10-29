import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

import '../models/profile.dart';
import '../services/authentication_service.dart';
import '../services/profile_service.dart';
import '../services/services_container.dart';

class Friend {
  String name;
  Friend(this.name);
}

class PlaylistInvitation extends StatefulWidget {
  final Function(String) onFriendSelected;
  final List<Profile> userFriends;

  PlaylistInvitation({required this.onFriendSelected, required this.userFriends});

  @override
  _PlaylistInvitationState createState() => _PlaylistInvitationState();
}

class _PlaylistInvitationState extends State<PlaylistInvitation> {
  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late Future<Profile> currentProfile;
  late Future<List<Profile>> profileFriends;
  late List<Profile> friends;

  List<Profile> dummydata = [
    Profile('id', 'alexfrey1', 'spotifyUID', 'assets/green_colored_logo.png'),
    Profile('id', 'alisajbgarcia', 'spotifyUID', 'assets/green_colored_logo.png'),
    Profile('id', 'zestythomae', 'spotifyUID', 'assets/green_colored_logo.png'),
    Profile('id', 'cmsale', 'spotifyUID', 'assets/green_colored_logo.png'),
  ];

  late List<bool> selectedStates;
  String selectedFriend = "";

  @override
  void initState() {
    super.initState();
    if(widget.userFriends == null) {
      friends = dummydata;
    }
    selectedStates = List.generate(friends.length, (index) => false);
  }

  void handleFriendSelection(int friendIndex) {
    setState(() {
      selectedFriend = friends[friendIndex].displayName;
      for (int i = 0; i < friends.length; i++) {
        selectedStates[i] = (i == friendIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return AlertDialog(
      backgroundColor: MixTapeColors.black,
      title: Text(
        'Invite a friend',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          fontSize: textScaleFactor * 20,
        ),
      ),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: screenWidth * 0.7,
              height: screenHeight * 0.12,
              child: Center(
                child: ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: selectedStates[index] ? MixTapeColors.mint : null,
                      onTap: () {
                        handleFriendSelection(index); // Handle friend selection
                        print("Tapped a friend: ${friends[index].displayName}");
                      },
                      selected: selectedStates[index],
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                      leading: Icon(
                        Icons.person,
                        color: selectedStates[index] ? MixTapeColors.green : Colors.white,
                      ),
                      title: Text(
                        friends[index].displayName,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat',
                          fontSize: textScaleFactor * 20,
                          color: selectedStates[index] ? MixTapeColors.green : Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenWidth * .2,
            height: screenHeight * .05,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              backgroundColor: MixTapeColors.green,
              onPressed: () {
                print(selectedFriend);
                widget.onFriendSelected(selectedFriend);
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: textScaleFactor * 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
