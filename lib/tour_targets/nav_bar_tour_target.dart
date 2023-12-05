import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:mixtape/widgets/playlist_widget.dart';

List<TargetFocus> addNavBarTourTargets({
  required GlobalKey friendsPageKey,
}){
  List<TargetFocus> targets = [];

  targets.add(
    TargetFocus(
      keyTarget: friendsPageKey,
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

  return targets;
}