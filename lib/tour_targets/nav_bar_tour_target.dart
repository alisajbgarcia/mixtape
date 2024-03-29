import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:mixtape/widgets/playlist_widget.dart';

List<TargetFocus> addNavBarTourTargets({
  required GlobalKey friendsPageKey,
  required GlobalKey profilePageKey,
  required BuildContext context,
}){
  List<TargetFocus> targets = [];
  final Size screenSize = MediaQuery.of(context).size;
  final textScaleFactor = MediaQuery.of(context).textScaleFactor;
  final double screenWidth = screenSize.width;
  final double screenHeight = screenSize.height;

  targets.add(
    TargetFocus(
      keyTarget: friendsPageKey,
      enableOverlayTab: true,
      shape: ShapeLightFocus.Circle,
      radius: 50,
      paddingFocus: 1,
      contents: [
        TargetContent(
          padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * .15),
          align: ContentAlign.top,
          builder: (context, controller) => Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.fromLTRB(screenWidth * .017,0,screenWidth * .017,0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Friends',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: textScaleFactor * 30,
                    ),
                  ),
                  Text(
                    'This is the friends page. View a list of your friends, or search for your friends to start making collaborative playlists! They must have a MixTape account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: textScaleFactor * 17,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * .025,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'assets/friends_page.png',
                      height: screenHeight * .5,
                      fit: BoxFit.cover,
                    ),
                  ),

                ],
              ),
            ),
          )
        ),
      ],
    ),
  );

  targets.add(
    TargetFocus(
      keyTarget: profilePageKey,
      enableOverlayTab: true,
      shape: ShapeLightFocus.Circle,
      radius: 50,
      paddingFocus: 1,
      contents: [
        TargetContent(
            padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * .15),
            align: ContentAlign.top,
            builder: (context, controller) => Container(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.fromLTRB(screenWidth * .017,0,screenWidth * .017,0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight * .045,
                    ),
                    Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: textScaleFactor * 30,
                      ),
                    ),
                    Text(
                      'This is the profile page. Your MixTape account is linked to your Spotify account.\n'
                      'You will be able to add a collection of songs from playlist MixTapes to your queue.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: textScaleFactor * 17,
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .025,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        'assets/profile_page.png',
                        height: screenHeight * .5,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
      ],
    ),
  );
  return targets;
}