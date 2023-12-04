import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:mixtape/tour_targets/nav_bar_tour_target.dart';

class NavBar extends StatelessWidget {
  BuildContext context;
  final int currentIndex;
  final Function(int) onTap;
  late TutorialCoachMark tutorialCoachMark;

  NavBar({required this.context, required this.currentIndex, required this.onTap});

  GlobalKey friendsPageKey = GlobalKey();

  void pageTour() {
    tutorialCoachMark = TutorialCoachMark(
      targets: addTourTargets(
          friendsPageKey: friendsPageKey),
      colorShadow: MixTapeColors.dark_gray,
      paddingFocus: 1,
      hideSkip: true,
      opacityShadow: 0,
      onSkip: () {
        return true;
      },
    );
  }

  void showTour() => Future.delayed(Duration(milliseconds: 500),
          () => tutorialCoachMark.show(context: context));

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if(true) {
        pageTour();
        showTour();
      }

      //openTutorial1();
    });
  }



  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Theme(
      data: ThemeData(
        canvasColor: MixTapeColors.black,
      ),
      child: BottomNavigationBar(
        backgroundColor: MixTapeColors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: MixTapeColors.green),
              label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(
              key: friendsPageKey,
              Icons.person_add,
              color: MixTapeColors.green
            ),
            label: 'Friends',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: MixTapeColors.green),
              label: 'Profile'
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: MixTapeColors.green,
        unselectedItemColor: MixTapeColors.green,
        onTap: onTap,
      ),
    );
  }
}
