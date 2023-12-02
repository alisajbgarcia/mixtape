import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

class PlaylistWidget extends StatelessWidget {
  const PlaylistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return InkWell(
      borderRadius: BorderRadius.circular(12.0),
      onTap: () {},
      child: Card(
        color: MixTapeColors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
          ),
          elevation: 3.0,
          //margin: EdgeInsets.all(screenWidth * .03),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * .005),
                    height: screenHeight * .17,
                    color: MixTapeColors.dark_gray,
                    child: Image.asset(
                        'assets/red_colored_logo.png',
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: screenWidth * .01, bottom: screenWidth * .005, left: screenWidth * .01, right: screenWidth * .01),
                    height: screenHeight * .17,
                    color: MixTapeColors.light_gray,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(screenWidth * .015),
                          height: screenHeight * .035,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'playlist',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: (22 * textScaleFactor),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: MixTapeColors.dark_gray,
                              padding: EdgeInsets.all(0),
                              fixedSize: Size(150, 15),
                            ),
                            onPressed: null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: MixTapeColors.dark_gray,
                                  radius: 30,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  "with ...",
                                  style: TextStyle(
                                    fontSize: (10 * textScaleFactor),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),

                        ),
                        Card(
                          color: MixTapeColors.light_gray,
                          elevation: 0.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "# songs",
                                style: TextStyle(
                                  fontSize: (12 * textScaleFactor),
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '## hr ## min',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: (12 * textScaleFactor),
                                ),
                              ),
                              Image.asset(
                                'assets/spotify/Spotify_Icon_RGB_Green.png',
                                height: screenHeight * .03,
                                width: screenHeight * .03,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
