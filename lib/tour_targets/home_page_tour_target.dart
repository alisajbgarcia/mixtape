import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:mixtape/widgets/playlist_widget.dart';

import '../utilities/colors.dart';

List<TargetFocus> addTourTargets({
  required GlobalKey profileKey,
  required GlobalKey notificationsPageKey,
  required BuildContext context,

}){
  List<TargetFocus> targets = [];
  final Size screenSize = MediaQuery.of(context).size;
  final textScaleFactor = MediaQuery.of(context).textScaleFactor;
  final double screenWidth = screenSize.width;
  final double screenHeight = screenSize.height;

  targets.add(
    TargetFocus(
      keyTarget: profileKey,
      enableOverlayTab: true,
      shape: ShapeLightFocus.RRect,
      radius: 10,
      paddingFocus: 1,
      contents: [
        TargetContent(
          //padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            align: ContentAlign.bottom,
            builder: (context, controller) => Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  PlaylistWidget(),
                  SizedBox(
                    height: screenHeight * .009,
                  ),
                  Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.white,
                    size: screenHeight * .045,
                  ),
                  SizedBox(
                    height: screenHeight * .0045,
                  ),
                  Text(
                    'This is the homepage',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: textScaleFactor * 20,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * .004
                  ),
                  Text(
                    'Once you\'ve started creating, you will be able to view your playlists here.'
                        'When you click on any playlist, you will be able to view its contents and add MixTapes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: textScaleFactor * 15,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * .05,
                  ),
                  Text(
                    'Tap anywhere on the screen to continue.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 15,
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
      keyTarget: notificationsPageKey,
      enableOverlayTab: true,
      shape: ShapeLightFocus.Circle,
      radius: 20,
      paddingFocus: 1,
      contents: [
        TargetContent(
            padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * .7),
            align: ContentAlign.bottom,
            builder: (context, controller) => Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                  Center(
                    child: Text(
                      'Notifications',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: textScaleFactor * 30,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Tap on the bell to see the notifications page.\n'
                      'View and filter alerts for events such as friend requests, playlist invitations, and when a MixTape has been added to a playlist !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontSize: textScaleFactor * 17,
                      ),
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