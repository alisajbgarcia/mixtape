import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mixtape/models/track_info.dart';
import 'package:mixtape/screens/home_page.dart';
import 'package:mixtape/screens/playlist_page.dart';
import 'package:mixtape/utilities/colors.dart';

import '../models/mixtape.dart';
import '../models/playlist.dart';
import '../models/profile.dart';
import '../services/authentication_service.dart';
import '../services/friendship_service.dart';
import '../services/mixtape_service.dart';
import '../services/playlist_service.dart';
import '../services/profile_service.dart';
import '../services/services_container.dart';
import 'friends_page.dart';

class FriendInfoPage extends StatefulWidget {
  String friendId;
  FriendInfoPage({
    required this.friendId,
  });

  @override
  State<FriendInfoPage> createState() => _FriendInfoPageState();
}

class _FriendInfoPageState extends State<FriendInfoPage> {
  late ProfileService profileService;
  late AuthenticationService authenticationService;
  late MixtapeService mixtapeService;
  late Future<Profile> currentProfile;
  late Future<Profile> friendProfile;
  late FriendshipService friendshipService;
  late PlaylistService playlistService;
  late Future<List<Playlist>> playlists;

  GlobalKey friendInfoPageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    profileService = ServicesContainer.of(context).profileService;
    authenticationService = ServicesContainer.of(context).authService;
    friendshipService = ServicesContainer.of(context).friendshipService;
    playlistService = ServicesContainer.of(context).playlistService;
    setState(() {
      currentProfile = profileService.getCurrentProfile();
      friendProfile = profileService.getProfileById(widget.friendId);
      playlists = playlistService.getPlaylistsForCurrentUser();
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
        key: friendInfoPageKey,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: FutureBuilder(
                  future: friendProfile,
                  builder: (context, profileSnapshot) {
                    if (!profileSnapshot.hasData || profileSnapshot.hasError) {
                      //return const Center(child: CircularProgressIndicator());
                      return Text(
                        'Friend Loading',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: (25.0 * textScaleFactor),
                        ),
                      );
                    }
                    final friend = profileSnapshot.data!;
                    return Column(children: [
                      Text(
                      friend.displayName,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: (25.0 * textScaleFactor),
                        color: Colors.white,
                      ),
                      softWrap: true,
                    ),
                      Text(
                        "Mixtapes you created: 4",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: (14.0 * textScaleFactor),
                          color: Colors.white,
                        ),
                        softWrap: true,
                      ),
                      Text(
                        "Mixtapes they created: 3",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: (14.0 * textScaleFactor),
                          color: Colors.white,
                        ),
                        softWrap: true,
                      ),
                    ]);
                  }),
            ),
          ],
        ),
        backgroundColor: MixTapeColors.black,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        toolbarHeight: screenHeight * .13,
        actions: [
          FutureBuilder(
              future: friendProfile,
              builder: (context, profileSnapshot) {
                if (!profileSnapshot.hasData || profileSnapshot.hasError) {
                  //return const Center(child: CircularProgressIndicator());
                  return Padding(
                    padding: EdgeInsets.all(screenHeight * .03),
                    child: ClipOval(
                      child: Container(
                        width: screenWidth * 0.15,
                        height: screenWidth * 0.15,
                        child: CircleAvatar(
                          backgroundColor: MixTapeColors.dark_gray,
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                final profile = profileSnapshot.data!;
                return Padding(
                  padding: EdgeInsets.all(screenHeight * .03),
                  child: ClipOval(
                    child: Container(
                      width: screenWidth * 0.15,
                      height: screenWidth * 0.15,
                      child: CachedNetworkImage(
                        imageUrl: profile.profilePicURL,
                        placeholder: (context, url) => CircleAvatar(
                          backgroundColor: MixTapeColors.dark_gray,
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            color: Colors.white70,
                          ),
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          backgroundColor: MixTapeColors.dark_gray,
                          radius: 30,
                          child: Icon(
                            Icons.person,
                            color: Colors.white70,
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
      body: FutureBuilder(
          future: playlists,
          builder: (context, playlistsSnapshot) {
            List<Playlist> cardData;
            if (!playlistsSnapshot.hasData || playlistsSnapshot.hasError) {
              print(playlistsSnapshot.error.toString());
              return const Center(child: CircularProgressIndicator());
              // cardData = dummydata;
              // print('oops');
            } else {
              cardData = playlistsSnapshot.data!;
            }

            // null assert is hella ugly, but the compiler doesn't appear to tell
            // that this won't be null because of the early return
            return Column(
              children: [
                Container(
                  height: screenHeight * .67,
                  padding: EdgeInsets.fromLTRB(screenWidth * .005,
                      screenWidth * .005, screenWidth * .005, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: cardData.map((playlist) {
                        if (playlist.initiator.id == widget.friendId ||
                            playlist.target.id == widget.friendId) {
                          return InkWell(
                            borderRadius: BorderRadius.circular(12.0),
                            onTap: () {
                              print('Tapped on Card ${playlist.name}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PlaylistPage(playlist: playlist)),
                              );
                            },
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12.0), // Adjust the radius as needed
                                ),
                                elevation: 3.0,
                                margin: EdgeInsets.all(screenWidth * .03),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              screenWidth * .005),
                                          height: screenHeight * .17,
                                          color: MixTapeColors.dark_gray,
                                          child: CachedNetworkImage(
                                            imageUrl: playlist.coverPicURL,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    'assets/green_colored_logo.png'),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    'assets/green_colored_logo.png'),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: screenWidth * .01,
                                              bottom: screenWidth * .005,
                                              left: screenWidth * .01,
                                              right: screenWidth * .01),
                                          height: screenHeight * .17,
                                          color: MixTapeColors.light_gray,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(
                                                    screenWidth * .015),
                                                height: screenHeight * .035,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    playlist.name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: (22 *
                                                          textScaleFactor),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              FilledButton(
                                                  style: FilledButton.styleFrom(
                                                    backgroundColor:
                                                        MixTapeColors.dark_gray,
                                                    padding: EdgeInsets.all(0),
                                                    fixedSize: Size(150, 15),
                                                  ),
                                                  onPressed: null,
                                                  child: FutureBuilder(
                                                    future: currentProfile,
                                                    builder: (context,
                                                        profileSnapshot) {
                                                      if (!profileSnapshot
                                                              .hasData ||
                                                          profileSnapshot
                                                              .hasError) {
                                                        return Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Image.asset(
                                                                'assets/green_colored_logo.png',
                                                                width: 25,
                                                                height: 25),
                                                            Text(
                                                              "loading friend",
                                                              style: TextStyle(
                                                                fontSize: (10 *
                                                                    textScaleFactor),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                      final profile =
                                                          profileSnapshot.data!;
                                                      return Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          if (profile.id ==
                                                              playlist
                                                                  .initiator.id)
                                                            CachedNetworkImage(
                                                                imageUrl: playlist
                                                                    .target
                                                                    .profilePicURL,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Image.asset(
                                                                        'assets/green_colored_logo.png'),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Image.asset(
                                                                        'assets/green_colored_logo.png'),
                                                                width: 25,
                                                                height: 25),
                                                          if (profile.id ==
                                                              playlist
                                                                  .initiator.id)
                                                            Text(
                                                              "with ${playlist.target.displayName}",
                                                              style: TextStyle(
                                                                fontSize: (10 *
                                                                    textScaleFactor),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          if (profile.id ==
                                                              playlist
                                                                  .target.id)
                                                            CachedNetworkImage(
                                                                imageUrl: playlist
                                                                    .initiator
                                                                    .profilePicURL,
                                                                placeholder: (context,
                                                                        url) =>
                                                                    Image.asset(
                                                                        'assets/green_colored_logo.png'),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Image.asset(
                                                                        'assets/green_colored_logo.png'),
                                                                width: 25,
                                                                height: 25),
                                                          if (profile.id ==
                                                              playlist
                                                                  .target.id)
                                                            Text(
                                                              "with ${playlist.initiator.displayName}",
                                                              style: TextStyle(
                                                                fontSize: (10 *
                                                                    textScaleFactor),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                        ],
                                                      );
                                                    },
                                                  )),
                                              Card(
                                                color: MixTapeColors.light_gray,
                                                elevation: 0.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${playlist.songCount} songs",
                                                      style: TextStyle(
                                                        fontSize: (12 *
                                                            textScaleFactor),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${getTotalTimeHHMM(playlist.totalDurationMS)}',
                                                      style: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontSize: (12 *
                                                            textScaleFactor),
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      'assets/spotify/Spotify_Icon_RGB_Green.png',
                                                      height:
                                                          screenHeight * .03,
                                                      width: screenHeight * .03,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          }),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.only(top: 10, bottom: 5, left: 30, right: 10),
        child: FloatingActionButton.extended(
          heroTag: "playlist_creation",
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
          ),
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: MixTapeColors.black,
              //title: const Text('Remove Friend?'),
              content: const Text('Would you like to remove this user as a friend?',
              style: TextStyle(
                    fontSize: (22),
                    color: Colors.white,
                   ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'CANCEL'),
                  child: const Text('CANCEL',
                  style: TextStyle(
                                  fontSize: (18),
                                  color: Colors.white,
                   ),
                  ),
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.pop(context, 'REMOVE'),
                    friendshipService.deleteFriendship(widget.friendId),
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FriendsPage())),
                  },
                  child: const Text('REMOVE',
                  style: TextStyle(
                                  fontSize: (18),
                                  color: Colors.white,
                   ),
                   ),
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.pop(context, 'BLOCK'),
                    friendshipService.blockUser(widget.friendId),
                    //Add user to blocked list
                    setState(() {}),
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FriendsPage())),
                  },
                  child: const Text('REMOVE AND BLOCK',
                    style: TextStyle(
                      fontSize: (18),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          label: Text(
            'Remove Friend',
            style: TextStyle(
              fontSize: textScaleFactor * 20,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          icon: Icon(
              Icons.delete,
              color: Colors.white,
          ),
          backgroundColor: Colors.red, // Change the button's color
        ),
      ),
    );
  }

  String getTotalTimeHHMM(int totalDurationMS) {
    int hours = getHoursFromMS(totalDurationMS);
    int minutes = getMinutesFromMS(totalDurationMS) - hours * 60;
    return "${hours}h ${minutes}m";
  }

  int getHoursFromMS(int milliseconds) {
    return (milliseconds / 3600000).truncate();
  }

  int getMinutesFromMS(int milliseconds) {
    return (milliseconds / 60000).truncate();
  }
}
