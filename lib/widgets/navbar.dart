import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  NavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        canvasColor: MixTapeColors.black,
      ),
      child: BottomNavigationBar(
        backgroundColor: MixTapeColors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: MixTapeColors.green),
              label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add, color: MixTapeColors.green),
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
