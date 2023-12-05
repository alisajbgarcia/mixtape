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
          padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * .7),
          align: ContentAlign.top,
          builder: (context, controller) => Container(
            alignment: Alignment.center,
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
                  'This is the friends page. Search for your friends to start making collaborative playlists ! They must have a MixTape account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: textScaleFactor * 17,
                  ),
                ),
              ],
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
            padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * .7),
            align: ContentAlign.top,
            builder: (context, controller) => Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                    'This is the profile page. Your MixTape account is linked to your Spotify account'
                    'You will be able to add a collection of songs from playlist MixTapes to your queue.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: textScaleFactor * 17,
                    ),
                  ),
                ],
              ),
            )
        ),
      ],
    ),
  );
  return targets;
}