import 'package:flutter/material.dart';
import 'package:mixtape/tour_targets/playlist_mixtape_tutorial_pages.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

List<TargetFocus> addPlaylistMixtapeTourTargets({
  required BuildContext context,
  required GlobalKey playlistMixtapeKey,
}){

  final Size screenSize = MediaQuery.of(context).size;
  final textScaleFactor = MediaQuery.of(context).textScaleFactor;
  final double screenWidth = screenSize.width;
  final double screenHeight = screenSize.height;
  List<TargetFocus> targets = [];

  targets.add(
    TargetFocus(
      keyTarget: playlistMixtapeKey,
      enableOverlayTab: false,
      shape: ShapeLightFocus.RRect,
      radius: 15,
      paddingFocus: 10,
      contents: [
        TargetContent(
            padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * .05),
            align: ContentAlign.top,
            builder: (context, controller) => PlaylistMixtapeTutorialPages()
        ),
      ],
    ),
  );

  return targets;
}