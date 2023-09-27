import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

class PlaylistCreationScreen extends StatefulWidget {
  const PlaylistCreationScreen({super.key});

  @override
  State<PlaylistCreationScreen> createState() => _PlaylistCreationScreenState();
}

class _PlaylistCreationScreenState extends State<PlaylistCreationScreen> {
  TextEditingController _textController = TextEditingController();
  String _textFieldValue = "";

  @override
  void dispose() {
    _textController.dispose(); // Dispose of the controller when the widget is disposed.
    super.dispose();
  }

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
              Container(
                height: screenHeight * .035, // Set
                width: screenWidth * .5,// the width of the container
                padding: EdgeInsets.fromLTRB(16, 100, 16, 16), // Add padding
                decoration: BoxDecoration(
                  color: MixTapeColors.black.withOpacity(.5), // Set the background color to gray
                  borderRadius: BorderRadius.circular(1.5), // Add rounded corners
                ),
                child: Text("Test"),
              ),
            ],

          ),

        ),
      ),
    );
  }
}
