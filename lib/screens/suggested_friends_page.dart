import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mixtape/services/friendship_service.dart';

import '../models/friendship.dart';
import '../models/profile.dart';
import '../services/authentication_service.dart';
import '../services/profile_service.dart';
import '../services/services_container.dart';
import '../utilities/navbar_pages.dart';
import '../widgets/navbar.dart';

import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/widgets/navbar.dart';

class SuggestedFriendsPage extends StatefulWidget {
  const SuggestedFriendsPage({Key? key}) : super(key: key);

  @override
  State<SuggestedFriendsPage> createState() => _SuggestedFriendsPageState();
}

class _SuggestedFriendsPageState extends State<SuggestedFriendsPage> {
  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late FriendshipService friendshipService;
  late Future<Profile> currentProfile;
  late Future<List<Profile>> friends;
  late Future<List<Profile>> suggestedFriends;

  void initState() {
    super.initState();

    profileService = ServicesContainer.of(context).profileService;
    authenticationService = ServicesContainer.of(context).authService;
    friendshipService = ServicesContainer.of(context).friendshipService;
    setState(() {
      currentProfile = profileService.getCurrentProfile();
      friends = profileService.getFriendsForCurrentUser();
      suggestedFriends = profileService.searchProfiles("");
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return const Placeholder();
  }
}
