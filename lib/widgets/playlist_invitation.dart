import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

class Friend {
  String name;
  Friend(this.name);
}

class PlaylistInvitation extends StatefulWidget {
  @override
  _PlaylistInvitationState createState() => _PlaylistInvitationState();
}

class _PlaylistInvitationState extends State<PlaylistInvitation> {
  List<Friend> friends = [
    Friend('alexfrey1'),
    Friend('alisajbgarcia'),
  ];

  // Create a list of selected states for each friend
  late List<bool> selectedStates;

  @override
  void initState() {
    super.initState();
    // Initialize the selectedStates list with false values
    selectedStates = List.generate(friends.length, (index) => false);
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
                setState(() {
                  selectedStates[i] = !selectedStates[i];
                });
                print("Tapped a friend: ${friends[i].name}");
              },
              selected: selectedStates[i],
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 1),
              leading: Icon(
                Icons.person,
                color: selectedStates[i] ? MixTapeColors.green : Colors.white, // Change the icon color to white when selected
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
                Navigator.of(context).pop();
              },
              child: Text(
                'Close,',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}