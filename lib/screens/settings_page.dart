import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mixtape/screens/approved_friends_page.dart';
import 'package:mixtape/screens/blocked_users_page.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:settings_ui/settings_ui.dart';
import '../models/profile.dart';
import '../models/settings.dart';
import '../services/authentication_service.dart';
import '../services/friendship_service.dart';
import '../services/profile_service.dart';
import '../services/services_container.dart';
import 'friend_info_page.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class FriendsInfo {
  String username;
  String image;

  FriendsInfo(this.username, this.image);
}

class _SettingsPageState extends State<SettingsPage> {
  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late FriendshipService friendshipService;
  late Future<Profile> currentProfile;
  late Future<List<Profile>> friends;
  late List<Profile> test;
  late Future<List<Profile>> searchFriends;
  HashSet<String> friendIDs = HashSet<String>();
  late Future<Settings> profileSettings;

  bool playlists_enabled = false;
  bool isSearchBarVisible = false;

  @override
  void initState() {
    super.initState();

    profileService = ServicesContainer.of(context).profileService;
    authenticationService = ServicesContainer.of(context).authService;
    friendshipService = ServicesContainer.of(context).friendshipService;
    setState(() {
      currentProfile = profileService.getCurrentProfile();
      friends = profileService.getBlockedProfilesForCurrentUser();
      searchFriends = profileService.searchProfiles("");
      profileSettings = profileService.getProfileSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: MixTapeColors.black,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text('Settings',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: (30.0 * textScaleFactor),
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: MixTapeColors.black,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        toolbarHeight: screenHeight * .13,
      ),
      body: FutureBuilder(
        future: profileSettings,
        builder: (context, settingsSnapshot) {
          if (!settingsSnapshot.hasData || settingsSnapshot.hasError) {
            print("low");
            print(settingsSnapshot);
            return Center(child: CircularProgressIndicator()); // Display a loading indicator while waiting for data.
          } else {
            final settings = settingsSnapshot.data!;
            playlists_enabled = settings.permissionNeededForPlaylists;

            return SettingsList(
              lightTheme: SettingsThemeData(settingsListBackground: MixTapeColors.black, settingsSectionBackground: MixTapeColors.light_gray, titleTextColor: Colors.white60, tileDescriptionTextColor: Colors.white, settingsTileTextColor: Colors.white, trailingTextColor: Colors.white60),
              darkTheme: SettingsThemeData(settingsListBackground: MixTapeColors.black, settingsSectionBackground: MixTapeColors.light_gray, titleTextColor: Colors.white60, tileDescriptionTextColor: Colors.white, settingsTileTextColor: Colors.white, trailingTextColor: Colors.white60),
              sections: [
                SettingsSection(
                  title: Text('Playlist Invitations'),
                  tiles: <SettingsTile>[
                    SettingsTile.switchTile(
                      onToggle: (value) async {
                        try {
                          Settings newSettings = await profileService
                              .updateProfileSettingsPermission(value);
                          setState(() {
                            profileSettings = profileService.getProfileSettings();
                          });
                        } catch (err) {
                          print(err);
                        }
                      },
                      initialValue: playlists_enabled,
                      leading: Icon(Icons.markunread_outlined),
                      title: Text('Require Approval For Playlists'),
                    ),
                    SettingsTile.navigation(
                      leading: Icon(Icons.group),
                      title: Text('Users Who Don\'t Require Approval'),
                      onPressed: (BuildContext context) {
                        // Navigator.push(context, MaterialPageRoute(
                        //     builder: (context) => const ApprovedFriendsPage()),);
                        Navigator.of(context).pushNamed(
                            '/approvedusers'
                        );
                      }
                    ),
                  ],
                ),
                SettingsSection(
                  title: Text('Users'),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      leading: Icon(Icons.block),
                      title: Text('Blocked Users'),
                      onPressed: (BuildContext context) {
                        // Navigator.push(context, MaterialPageRoute(
                        // builder: (context) => const BlockedUsersPage()),);
                        Navigator.of(context).pushNamed(
                            '/blockedusers'
                        );
                      }
                    ),
                  ]
                ),
              ],
            );
          }
        }
      ),
    );
  }
}