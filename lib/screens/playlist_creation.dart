import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

class PlaylistCreationScreen extends StatefulWidget {
  const PlaylistCreationScreen({super.key});

  @override
  State<PlaylistCreationScreen> createState() => _PlaylistCreationScreenState();
}

class _PlaylistCreationScreenState extends State<PlaylistCreationScreen> {

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      color: MixTapeColors.black,
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 40, 5, 0),
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
            color: MixTapeColors.black,
            image: DecorationImage(
              image: AssetImage(
                'assets/mixtape_image.png',
              ),
              alignment: Alignment.topCenter,
              scale: 1.04,
            ),
          ),
          child: Column(
            children: [
              Text(
                "This is a custom font",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "This is a custom font",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],

          ),

        ),
      ),
    );
  }
}
