import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

import 'package:flutter/services.dart' show rootBundle;

import '../screens/home_page.dart';

class WelcomeDialog extends StatefulWidget {
  final Function(bool) startTutorial;

  WelcomeDialog({required this.startTutorial});

  @override
  State<WelcomeDialog> createState() => _WelcomeDialogState();
}

class _WelcomeDialogState extends State<WelcomeDialog> {

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return AlertDialog(
      backgroundColor: MixTapeColors.dark_gray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0), // Adjust the border radius
      ),
      contentTextStyle: TextStyle(color: Colors.white),
      contentPadding: EdgeInsets.all(0),
      title: Text(
        "Welcome to MixTape",
        style: TextStyle(
            fontSize: textScaleFactor * 23,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            color: Colors.white
        ),
      ),
      content: Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        color: MixTapeColors.dark_gray,
        height: screenHeight * .2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/green_colored_logo.png',
              scale: screenHeight * .02,
            )
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                widget.startTutorial(false);
                Navigator.pop(context);
              },
              child: Text(
                'SKIP',
                style: TextStyle(
                  fontSize: textScaleFactor * 15,
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                widget.startTutorial(true);
                Navigator.pop(context);
              },
              child: Text(
                'GET STARTED >',
                style: TextStyle(
                  fontSize: textScaleFactor * 15,
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
