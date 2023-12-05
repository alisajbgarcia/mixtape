import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:mixtape/widgets/playlist_widget.dart';

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
                    height: 10,
                  ),
                  Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'This is the homepage',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Once you\'ve started creating, you will be able to view your playlists here',
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
                    'Notifications',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: textScaleFactor * 30,
                    ),
                  ),
                  Text(
                    'This is the notifications page'
                    'View and filter alerts for events such as friend requests, playlist invitations, and when a MixTape has been added to a playlist !',
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