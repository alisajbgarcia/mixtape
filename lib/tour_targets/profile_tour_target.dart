import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

List<TargetFocus> addTourTargets({
  required GlobalKey introKey,
  required GlobalKey profileKey,
}){
  List<TargetFocus> targets = [];

  targets.add(
    TargetFocus(
      keyTarget: profileKey,
      alignSkip: Alignment.bottomLeft,
      shape: ShapeLightFocus.Circle,
      radius: 20,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          builder: (context, controller) => Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('This is your Spotify profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                    fontSize: 15,
                  ),
                )
              ],
            ),
          )
        ),
      ],
    ),
  );

  return targets;
}