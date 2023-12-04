import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:mixtape/widgets/playlist_widget.dart';

List<TargetFocus> addNavBarTourTargets({
  required GlobalKey friendsPageKey,
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

  return targets;
}