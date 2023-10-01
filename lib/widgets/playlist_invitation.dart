import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

class Friend {
  String name;
  Friend(this.name);
}

class PlaylistInvitation extends StatefulWidget {
  final Function(String) onFriendSelected;

  PlaylistInvitation({required this.onFriendSelected});
  @override
  _PlaylistInvitationState createState() => _PlaylistInvitationState();
}

class _PlaylistInvitationState extends State<PlaylistInvitation> {
  List<Friend> friends = [
    Friend('alexfrey1'),
    Friend('alisajbgarcia'),
  ];

  late List<bool> selectedStates;
  String selectedFriend = ""; // Define selectedFriend as an instance variable

  @override
  void initState() {
    super.initState();
    selectedStates = List.generate(friends.length, (index) => false);
  }

  void handleFriendSelection(int friendIndex) {
    setState(() {
      selectedFriend = friends[friendIndex].name;
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

    List<Widget> listTiles = [];
    for (int i = 0; i < friends.length; i++) {
      listTiles.add(
        Container(
          width: screenWidth * 0.7,
          height: screenHeight * 0.05,
          child: Center(
            child: ListTile(
              tileColor: selectedStates[i] ? MixTapeColors.mint : null,
              onTap: () {
                handleFriendSelection(i); // Handle friend selection
                print("Tapped a friend: ${friends[i].name}");
              },
              selected: selectedStates[i],
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 1),
              leading: Icon(
                Icons.person,
                color: selectedStates[i] ? MixTapeColors.green : Colors.white,
              ),
              title: Text(
                friends[i].name,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Montserrat',
                  fontSize: textScaleFactor * 20,
                  color: selectedStates[i] ? MixTapeColors.green : Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }

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
          children: listTiles,
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
