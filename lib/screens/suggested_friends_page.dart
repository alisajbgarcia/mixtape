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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
