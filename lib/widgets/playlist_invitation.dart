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
              width: screenWidth * .7,
              height: screenHeight * .05,
              child: Center(
                child: ListTile(
                  tileColor: selectedStates[0] ? MixTapeColors.light_gray : null,
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                  leading: Icon(Icons.face),
                  title: Text(
                    'alexfrey1',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat',
                      fontSize: textScaleFactor * 20,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedStates[0] = !selectedStates[0]; // Toggle the selected state
                    });
                    print("tapped a friend");
                  },
                ),
              ),
            ),
            Container(
              width: screenWidth * .7,
              height: screenHeight * .05,
              child: Center(
                child: ListTile(
                  tileColor: selectedStates[1] ? MixTapeColors.light_gray : null,
                  onTap: () {
                    setState(() {
                      selectedStates[1] = !selectedStates[1]; // Toggle the selected state
                    });
                    print("tapped a friend");
                  },
                  selectedColor: MixTapeColors.mint,
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                  leading: Icon(Icons.face),
                  title: Text(
                    'alexfrey1',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat',
                      fontSize: textScaleFactor * 20,
                      color: Colors.white,
                    ),
                  ),
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

