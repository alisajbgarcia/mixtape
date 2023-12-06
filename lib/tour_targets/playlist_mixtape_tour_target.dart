import 'package:flutter/material.dart';
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
      shape: ShapeLightFocus.RRect,
      radius: 15,
      paddingFocus: 50,
      contents: [
        TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_upward_rounded,
                    color: Colors.white,
                    size: 50,
                  ),
                  Text('This is your Spotify profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('This is linked to your account. '
                      'You will be able to create collaborative playlists and add a collection of songs to your queue.',
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