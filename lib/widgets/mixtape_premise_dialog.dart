import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

class MixTapePremiseDialog extends StatelessWidget {
  const MixTapePremiseDialog({super.key});

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
        height: screenHeight * .25,
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

