import 'package:flutter/material.dart';
import 'package:mixtape/main.dart';
import 'package:mixtape/models/track_info.dart';
import 'package:mixtape/screens/home_page.dart';
import 'package:mixtape/screens/playlist_page.dart';
import 'package:mixtape/utilities/colors.dart';

import '../models/mixtape.dart';
import '../models/playlist.dart';
import '../models/profile.dart';
import '../services/authentication_service.dart';
import '../services/mixtape_service.dart';
import '../services/profile_service.dart';
import '../services/services_container.dart';


class TapeInfoPage extends StatefulWidget {

  // final int tape_id;
  // final int spotify_id;
  // final String title;
  // final List<TrackInfo> songs;
  // final String description;
  Mixtape mixtape;
  final Playlist playlist;
  TapeInfoPage(
      {
        required this.mixtape,
        required this.playlist
      });

  @override
  State<TapeInfoPage> createState() => _TapeInfoPageState();
}

class _TapeInfoPageState extends State<TapeInfoPage> {
  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late MixtapeService mixtapeService;
  late Future<Profile> currentProfile;

  Icon getIconForReaction(ReactionType type) {
    switch (type) {
      case ReactionType.LIKE:
        return Icon(Icons.thumb_up, color: Colors.white,);
      case ReactionType.DISLIKE:
        return Icon(Icons.thumb_down, color: Colors.white,);
      case ReactionType.HEART:
        return Icon(Icons.favorite, color: Colors.pinkAccent,);
      case ReactionType.FIRE:
        return Icon(Icons.whatshot, color: Colors.red,);
    }
  }

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
              Column(
                children: [
                  SizedBox(height: screenHeight * .05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ReactionType.values.map((type) {
                      return IconButton(
                        icon: getIconForReaction(type),
                        onPressed: () async {
                         widget.mixtape = await mixtapeService.addReactionForCurrentUser(widget.playlist.id, widget.mixtape.id, type: type.name);
                         print("reaction added");
                         setState(() {
                           // set the state
                         });
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Reactions:',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: widget.mixtape.reactions.map((reaction) {
                      return ListTile(
                        title: Text('${reaction.reactor.displayName} reacted with a',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        trailing: Container(
                          child: getIconForReaction(reaction.reactionType),
                        ),
                      );
                    }).toList(),
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

                                      Navigator.of(context).pop();
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
                                color: Colors.white
                              ),
                            ),
                          ),
                          icon: Icon(Icons.delete, color: Colors.white),
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