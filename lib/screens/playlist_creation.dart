import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/screens/search_page.dart';
import 'package:mixtape/widgets/playlist_invitation_sent.dart';
import 'package:mixtape/widgets/image_upload.dart';

import '../services/authentication_service.dart';
import '../services/playlist_service.dart';
import '../services/services_container.dart';
import '../widgets/playlist_invitation.dart';

class PlaylistCreationScreen extends StatefulWidget {
  const PlaylistCreationScreen({super.key});

  @override
  State<PlaylistCreationScreen> createState() => _PlaylistCreationScreenState();
}

class _PlaylistCreationScreenState extends State<PlaylistCreationScreen> {
  TextEditingController _textController = TextEditingController();
  String _textFieldValue = "";
  String selectedFriend = "";

  // late PlaylistService playlistService;
  // late AuthenticationService authenticationService;
  //
  // @override
  // void initState(){
  //   super.initState();
  //   playlistService = ServicesContainer.of(context).playlistService;
  //   authenticationService = ServicesContainer.of(context).authService;
  // }

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
        return ImageUpload();
      },
    );
  }

  // Function to open the PlaylistInvitation alert dialog
  void openPlaylistInvitationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PlaylistInvitation(
          onFriendSelected: (String friendName) {
            setState(() {
              selectedFriend = friendName;
            });
            print('Selected friend!: $friendName');
          },
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

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    // Callback function to handle the selected friend
    void handleFriendSelection(String friendName) {
      setState(() {
        selectedFriend = friendName;
      });
    }
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: MixTapeColors.black,
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
                  top: screenHeight * .06, // Adjust the top position as needed
                  child: Center(
                    child: Container(
                      height: screenHeight * .05, // Set
                      width: screenWidth * .55,
                      decoration: BoxDecoration(
                        color: MixTapeColors.black.withOpacity(.5), // Set the background color to gray
                        borderRadius: BorderRadius.circular(3), // Add rounded corners
                      ),
                      child: SingleChildScrollView(
                          child: TextField(
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: textScaleFactor * 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(10, 15, 0, 0),
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
                          padding: EdgeInsets.fromLTRB(screenWidth * .05, 0, 0, 0),
                          child: Container(
                            decoration: ShapeDecoration(
                              color: MixTapeColors.light_gray,
                              shape: CircleBorder(),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.add_photo_alternate_outlined),
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
                          padding: EdgeInsets.fromLTRB(0, 0, screenWidth * .05, 0),
                          child: IconButton(
                            icon: Icon(
                              Icons.person_add_alt_rounded,
                              size: screenHeight * .04,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              print("do you have friends");
                              openPlaylistInvitationDialog(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * 0.05),
              child: FittedBox(
                fit: BoxFit.scaleDown, // This will scale the child down if it overflows
                child: FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  heroTag: "playlist_invitation",
                  onPressed: () {
                    print("send invitation");
                    openPlaylistInvitationSentDialog(context);
                    // playlistService.createPlaylistForCurrentUser(name: "name of playlist", description: "desc", coverPicURL: "assets/green_colored_logo.png", requestedUserID: "abe7e5b2-7915-4d01-8d9e-8672b0efb139");
                  },
                  label: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'Invite $selectedFriend',
                      style: TextStyle(
                        fontSize: textScaleFactor * 20,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  backgroundColor: MixTapeColors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
