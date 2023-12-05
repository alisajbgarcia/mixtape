import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:mixtape/tour_targets/nav_bar_tour_target.dart';

class NavBar extends StatelessWidget {
  BuildContext context;
  GlobalKey? friendsPageKey;
  GlobalKey? profileKey;
  final int currentIndex;
  final Function(int) onTap;
  bool newUser = false;

  NavBar({required this.context, required this.currentIndex, required this.onTap});
  NavBar.Tutorial({required this.context, required this.currentIndex, required this.onTap, required this.friendsPageKey, required this.profileKey});


  @override
  Widget build(BuildContext context) {

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
