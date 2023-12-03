import 'package:flutter/material.dart';
import 'package:mixtape/models/track_info.dart';
import 'package:mixtape/screens/home_page.dart';
import 'package:mixtape/screens/playlist_screen.dart';
import 'package:mixtape/utilities/colors.dart';

import '../models/mixtape.dart';
import '../models/playlist.dart';
import '../models/profile.dart';
import '../services/authentication_service.dart';
import '../services/friendship_service.dart';
import '../services/mixtape_service.dart';
import '../services/profile_service.dart';
import '../services/services_container.dart';


class FriendInfoScreen extends StatefulWidget {
  @override
  State<FriendInfoScreen> createState() => _FriendInfoScreenState();
}

class _FriendInfoScreenState extends State<FriendInfoScreen> {
  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late MixtapeService mixtapeService;
  late Future<Profile> currentProfile;
  late FriendshipService friendshipService;

  @override
  void initState() {
    super.initState();
    profileService = ServicesContainer.of(context).profileService;
    authenticationService = ServicesContainer.of(context).authService;
    friendshipService = ServicesContainer.of(context).friendshipService;
    setState(() {
      currentProfile = profileService.getCurrentProfile();
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
        body: Container(
          width: screenWidth,
          height: screenHeight,
          color: MixTapeColors.black,
          child: FutureBuilder(
              future: currentProfile,
                  builder: (context, profileSnapshot) {
                    if (profileSnapshot.hasData) {
                      final profile = profileSnapshot.data! as Profile;
                      if (profile.id == widget.mixtape.creator.id) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, 0, 0, screenHeight * .05),
                          child: FloatingActionButton.extended(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15), // Adjust the radius as needed
                            ),
                            heroTag: "mixtape_creation",
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor: MixTapeColors.black,
                                //title: const Text('Remove Friend?'),
                                content: const Text(
                                  'Would you like to delete this MixTape?',
                                  style: TextStyle(
                                    fontSize: (22),
                                    color: Colors.white,
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'CANCEL'),
                                    child: const Text(
                                      'CANCEL',
                                      style: TextStyle(
                                        fontSize: (22),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      try {
                                        await mixtapeService
                                            .deleteMixtapeInPlaylistForCurrentUser(
                                            widget.playlist.id, widget.mixtape.id);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HomePage(),
                                            )
                                        );
                                      } catch (err) {
                                        print(err);
                                        Navigator.pop(context, 'ERROR');
                                      }
                                    },
                                    child: const Text(
                                      'YES',
                                      style: TextStyle(
                                        fontSize: (22),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            label: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                'Delete Mixtape',
                                style: TextStyle(
                                  fontSize: textScaleFactor * 20,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            icon: Icon(Icons.delete),
                            backgroundColor: Colors
                                .red, // Change the button's color
                          ),
                        );
                      } else {
                        return Text(
                            "Mixtape was created by ${widget.mixtape.creator
                                .displayName}");
                      }
                    } else {
                      return Text("Awaiting profile data");
                    }
                  }
              ),

            ],
          ),
        ));
  }
}