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
      decoration: BoxDecoration(
        color: MixTapeColors.black,
      ),


    );
  }
}
