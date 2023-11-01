import 'package:flutter/material.dart';
import 'package:mixtape/models/track_info.dart';
import 'package:mixtape/screens/home_page.dart';
import 'package:mixtape/screens/playlist_screen.dart';
import 'package:mixtape/utilities/colors.dart';

import '../models/mixtape.dart';
import '../models/playlist.dart';
import '../models/profile.dart';
import '../services/authentication_service.dart';
import '../services/mixtape_service.dart';
import '../services/profile_service.dart';
import '../services/services_container.dart';


class TapeInfoScreen extends StatefulWidget {
  // final int tape_id;
  // final int spotify_id;
  // final String title;
  // final List<TrackInfo> songs;
  // final String description;
  final Mixtape mixtape;
  final Playlist playlist;
  const TapeInfoScreen(
      {
        required this.mixtape,
        required this.playlist
      });

  @override
  State<TapeInfoScreen> createState() => _TapeInfoScreenState();
}

class _TapeInfoScreenState extends State<TapeInfoScreen> {
  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late MixtapeService mixtapeService;
  late Future<Profile> currentProfile;

  @override
  void initState() {
    super.initState();

    mixtapeService = ServicesContainer.of(context).mixtapeService;
    profileService = ServicesContainer.of(context).profileService;
    authenticationService = ServicesContainer.of(context).authService;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                    child: Image.asset(
                      'assets/mixtape_image.png',
                      scale: 1.01,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top:
                        screenHeight * .06, // Adjust the top position as needed
                    child: Center(
                      child: Container(
                        height: screenHeight * .05, // Set
                        width: screenWidth * .55,
                        decoration: BoxDecoration(
                          color: MixTapeColors.black.withOpacity(
                              .5), // Set the background color to gray
                          borderRadius:
                              BorderRadius.circular(3), // Add rounded corners
                        ),
                        child: FittedBox(
                          fit: BoxFit
                              .scaleDown, // This makes the text shrink to fit
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(children: [
                              Text(
                                widget.mixtape.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top:
                    screenHeight * .22, // Adjust the top position as needed
                    child: Center(
                      child: Container(
                        height: screenHeight * .06, // Set
                        width: screenWidth * .55,
                        decoration: BoxDecoration(
                          color: MixTapeColors.black.withOpacity(
                              .5), // Set the background color to gray
                          borderRadius:
                          BorderRadius.circular(3), // Add rounded corners
                        ),
                        child: FittedBox(
                          fit: BoxFit
                              .scaleDown, // This makes the text shrink to fit
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(children: [
                              Text(
                                widget.mixtape.description,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: widget.mixtape.songs.map((song) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12.0), // Adjust the radius as needed
                          ),
                          elevation: 0.0,
                          color: MixTapeColors.dark_gray,
                          margin: EdgeInsets.all(15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Container(
                              color: MixTapeColors.dark_gray,
                              height: screenHeight * .1,
                              width: screenWidth * .9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: screenWidth * .9,
                                    height: screenHeight * .07,
                                    color: MixTapeColors.dark_gray,
                                    child: Card(
                                      elevation: 0.0,
                                      color: MixTapeColors.dark_gray,
                                      child: ListTile(
                                        title: Text(
                                          song.name,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: textScaleFactor * 16,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "${song.artistNames[0]} • ${song.albumName}",
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            fontSize: textScaleFactor * 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              FutureBuilder(
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
                          onPressed: () async {
                            print("create mixtape");
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
                            }
                          },
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
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.only(top: 200),
//           child: Column(children: [
//             Text(widget.title, style: TextStyle(color: Colors.white)),
//             Image.asset(
//               widget.image,
//               width: screenWidth * .4,
//               height: screenHeight * .4,
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 // Use SingleChildScrollView instead of ListView
//                 child: Column(
//                     children: widget.songs.map((song) {
//                   return Text(song.title,
//                       style: TextStyle(color: Colors.white));
//                 }).toList()),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
