import 'package:flutter/material.dart';
import 'package:mixtape/screens/friends_page.dart';
import 'package:mixtape/screens/home_page.dart';
import 'package:mixtape/screens/profile_page.dart';

class NavbarPages {
  static List<Widget> navBarPages = <Widget>[
    HomePage(),
    FriendsPage(),
    ProfilePage(),
  ];
}