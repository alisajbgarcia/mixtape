import 'package:flutter/material.dart';
import 'package:mixtape/screens/home_page.dart';
import 'package:mixtape/utilities/colors.dart';

class PlaylistInvitationSent extends StatelessWidget {
  const PlaylistInvitationSent({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return AlertDialog(
      backgroundColor: MixTapeColors.black,
      content: Text(
        "Invitation sent",
        style: TextStyle(
          fontSize: textScaleFactor * 20,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          color: Colors.white
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
        ),
      ],
    );
  }
}
