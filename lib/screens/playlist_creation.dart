import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/widgets/playlist_invitation_sent.dart';
import 'package:mixtape/widgets/image_upload.dart';

import '../services/authentication_service.dart';
import '../services/playlist_service.dart';
import '../services/services_container.dart';
import '../models/playlist.dart';
import '../models/profile.dart';
import '../services/profile_service.dart';
import '../widgets/playlist_invitation.dart';

class PlaylistCreationPage extends StatefulWidget {

  const PlaylistCreationPage({super.key});

  @override
  State<PlaylistCreationPage> createState() => _PlaylistCreationPageState();
}

class _PlaylistCreationPageState extends State<PlaylistCreationPage> {
  TextEditingController _textController = TextEditingController();
  String playlistName = "";
  String playlistTargetName = "";
  XFile playlistPhoto = XFile("");
  late Profile playlistTargetProfile;

  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late PlaylistService playlistService;

  late Future<Profile> currentProfile;
  late Future<List<Profile>> friends;
  late List<Profile> userFriends;
  late CreatePlaylistDTO newPlaylist;

  @override
  void initState() {
    super.initState();

    profileService = ServicesContainer.of(context).profileService;
    authenticationService = ServicesContainer.of(context).authService;
    playlistService = ServicesContainer.of(context).playlistService;
    setState(() {
      currentProfile = profileService.getCurrentProfile();
      friends = profileService.getFriendsForCurrentUser();
    });
  }

  @override
  void dispose() {
    _textController.dispose(); // Dispose of the controller when the widget is disposed.
    super.dispose();
  }

  // Function to open the ImageUpload alert dialog
  void openImageUploadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImageUpload(
          photoFile: (XFile photoFile) {
            setState(() {
              playlistPhoto = photoFile;
            });
          },
          photoURL: playlistPhoto.path,
        );
      },
    );
  }

  // Function to open the PlaylistInvitation alert dialog
  void openPlaylistInvitationDialog(BuildContext context, List<Profile> userFriends) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PlaylistInvitation(
            onFriendSelected: (String friendName) {
              setState(() {
                playlistTargetName = friendName;
              });
              print('Selected friend!: $friendName');
            },
            userFriends: userFriends
        );
      },
    );
  }

  void openPlaylistInvitationSentDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PlaylistInvitationSent();
      },
    );
  }

  // function to return a profile of the friends name
  Profile? getFriend(String name) {
    for(Profile profile in userFriends) {
      if(profile.displayName == name) {
        return profile;
      }
    }
    return null;
  }

  // function to create a new playlist and upload a corresponding coverPic
  Future<Playlist?> createPlaylist(CreatePlaylistDTO createPlaylistDTO) async {
    print('the following playlist will be created');
    print(createPlaylistDTO);
    print('PLAYLIST PHOTO ${playlistPhoto.path}');
    CreatePlaylistResponse playlist = await playlistService.createPlaylistAndInvitation(createPlaylistDTO);
    Playlist newPlaylist;
    if (playlist != null) {
      print('playlist successfully created wahoo');
      String playlistId = playlist.id;
      final newPlaylist = await playlistService.setProfilePicForPlaylist(playlistId, playlistPhoto);
      print(newPlaylist.coverPicURL);
    } else {
      print('womp womp');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;


    // Callback function to handle the selected friend
    return FutureBuilder(
        future: friends,
        builder: (context, friendsSnapshot) {
          if(!friendsSnapshot.hasData || friendsSnapshot.hasError) {
            return CircularProgressIndicator();
          } else {
            userFriends = friendsSnapshot.data!;
          }
          return Scaffold(
            body: Container(
              width: screenWidth,
              height: screenHeight,
              color: MixTapeColors.black,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 20, 5, screenHeight * .2),
                          child: Image.asset(
                            'assets/mixtape_image.png',
                            scale: 1.02,
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: screenHeight * .06,
                          // Adjust the top position as needed
                          child: Center(
                            child: Container(
                              height: screenHeight * .05, // Set
                              width: screenWidth * .55,
                              decoration: BoxDecoration(
                                color: MixTapeColors.black.withOpacity(.5),
                                // Set the background color to gray
                                borderRadius: BorderRadius.circular(
                                    3), // Add rounded corners
                              ),
                              child: SingleChildScrollView(
                                child: TextField(
                                  controller: _textController,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: textScaleFactor * 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(
                                        10, 15, 0, 0),
                                    border: InputBorder.none,
                                    focusColor: Colors.white,
                                    hintText: "Name",
                                    hintStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: textScaleFactor * 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.create_rounded,
                                      color: Colors.white,
                                      size: 15,
                                    ), // The trailing icon
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            top: screenHeight * .24,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        screenWidth * .05, 0, 0, 0),
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        color: MixTapeColors.light_gray,
                                        shape: CircleBorder(),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                            Icons.add_photo_alternate_outlined),
                                        color: Colors.white,
                                        onPressed: () {
                                          openImageUploadDialog(context);
                                        },
                                      ),
                                    ),
                                  ),
                                ),

                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0, 0, screenWidth * .05, 0),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.person_add_alt_rounded,
                                        size: screenHeight * .04,
                                      ),
                                      color: Colors.white,
                                      onPressed: () {
                                        print("do you have friends");
                                        openPlaylistInvitationDialog(
                                            context, userFriends);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    ),

                    playlistTargetName.isNotEmpty ? Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * 0.05),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        // This will scale the child down if it overflows
                        child: FloatingActionButton.extended(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          heroTag: "playlist_invitation",
                          onPressed: () async {
                            print("send invitation");
                            openPlaylistInvitationSentDialog(context);
                            playlistName = _textController.text;
                            playlistTargetProfile = getFriend(playlistTargetName)!;
                            newPlaylist = CreatePlaylistDTO(playlistName, "", "", playlistTargetProfile.id);
                            createPlaylist(newPlaylist);
                          },
                          label: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                              'Invite $playlistTargetName',
                              style: TextStyle(
                                fontSize: textScaleFactor * 20,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          backgroundColor: MixTapeColors.green,
                        ),
                      ),
                    ) : Container(),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}