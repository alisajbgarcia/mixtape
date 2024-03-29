import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mixtape/main.dart';
import 'package:mixtape/screens/home_page.dart';
import 'package:mixtape/screens/tape_creation.dart';
import 'package:mixtape/screens/tape_info_page.dart';
import 'package:mixtape/services/services_container.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/screens/search_page.dart';
import '../models/mixtape.dart';
import '../models/playlist.dart';
import '../models/profile.dart';
import '../models/track_info.dart';
import '../services/authentication_service.dart';
import '../services/mixtape_service.dart';
import '../services/services_container.dart';

import '../services/playlist_service.dart';


class MixTapeInfo {
  String title;
  String image;
  int numSongs;
  List<TrackInfo> songs;
  String description;

  MixTapeInfo(this.title, this.image, this.numSongs, this.songs,
      [this.description = ""]);
}

class PlaylistPage extends StatefulWidget {
  final Playlist playlist;
  const PlaylistPage({required this.playlist});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  // API call to get playlist info
  late Future<List<Mixtape>> mixtapes;
  late AuthenticationService authenticationService;
  late MixtapeService mixtapeService;
  late PlaylistService playlistService;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    mixtapeService = ServicesContainer.of(context).mixtapeService;
    authenticationService = ServicesContainer.of(context).authService;
    setState(() {
      mixtapes =
          mixtapeService.getMixtapesForPlaylistCurrentUser(widget.playlist.id);
    });

    playlistService = ServicesContainer.of(context).playlistService;
  }

  _onDeletePlaylist(String playlistId) {
    playlistService.deletePlaylist(playlistId);
  }

  Future<void> _refresh() {
    setState(() {
      mixtapes =
          mixtapeService.getMixtapesForPlaylistCurrentUser(widget.playlist.id);
    });
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
      body: FutureBuilder(
          future: mixtapes,
          builder: (context, profileSnapshot) {
            if (!profileSnapshot.hasData || profileSnapshot.hasError) {
              return const Center(child: CircularProgressIndicator(), );
            }
            final cardData = profileSnapshot.data!;
            print("length");
            print(cardData.length);

            return Container(
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
                        top: screenHeight *
                            .06, // Adjust the top position as needed
                        child: Center(
                          child: Container(
                            height: screenHeight * .05, // Set
                            width: screenWidth * .55,
                            decoration: BoxDecoration(
                              color: MixTapeColors.black.withOpacity(
                                  .5), // Set the background color to gray
                              borderRadius: BorderRadius.circular(
                                  3), // Add rounded corners
                            ),
                            child: FittedBox(
                              fit: BoxFit
                                  .scaleDown, // This makes the text shrink to fit
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  widget.playlist.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * .8,
                        top: screenHeight * .05,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.white,
                          iconSize: textScaleFactor * 30,
                          onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: MixTapeColors.black,
                              //title: const Text('Remove Friend?'),
                              content: const Text('Would you like to delete this playlist?',
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
                                      fontSize: (22),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => {Navigator.pop(context, 'YES'),
                                    _onDeletePlaylist(widget.playlist.id),
                                    Navigator.of(context).pushReplacementNamed(
                                        '/home'),

                                  },
                                  child: const Text('YES',
                                    style: TextStyle(
                                      fontSize: (22),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: screenHeight *
                            .22, // Adjust the top position as needed
                        child: Center(
                          child: Container(
                            height: screenHeight * .05, // Set
                            width: screenWidth * .55,
                            decoration: BoxDecoration(
                              color: MixTapeColors.black.withOpacity(
                                  .5), // Set the background color to gray
                              borderRadius: BorderRadius.circular(
                                  3), // Add rounded corners
                            ),
                            child: FittedBox(
                              fit: BoxFit
                                  .scaleDown, // This makes the text shrink to fit
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  "${widget.playlist.songCount} songs, ${getTotalTimeHHMM(widget.playlist.totalDurationMS)}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth * .04,
                        top: screenHeight *
                            .25, // Adjust the top position as needed
                        //child: Text('here', style: TextStyle(color: Colors.white)),
                        child: CachedNetworkImage(
                            imageUrl: widget.playlist.initiator.profilePicURL,
                            placeholder: (context, url) => Image.asset('assets/green_colored_logo.png'),
                            errorWidget: (context, url, error) => Image.asset('assets/green_colored_logo.png'),
                            width: screenWidth * .1,
                            height: screenWidth * .1
                        ),
                      ),
                      Positioned(
                        left: screenWidth * .01,
                        top: screenHeight * .22, // Adjust the top position as needed
                        //child: Text('here', style: TextStyle(color: Colors.white)),
                        child: Text('+ ${getSongsAddedByUser(widget.playlist.mixtapes, widget.playlist.initiator)} songs',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: textScaleFactor * 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                      Positioned(
                        left: screenWidth * .75,
                        right: 0,
                        top: screenHeight *
                            .25, // Adjust the top position as needed
                        //child: Text('here', style: TextStyle(color: Colors.white)),
                        child: CachedNetworkImage(
                            imageUrl: widget.playlist.target.profilePicURL,
                            placeholder: (context, url) => Image.asset('assets/green_colored_logo.png'),
                            errorWidget: (context, url, error) => Image.asset('assets/green_colored_logo.png'),
                            width: screenWidth * .1,
                            height: screenWidth * .1
                        ),
                      ),
                      Positioned(
                        left: screenWidth * .74,
                        top: screenHeight * .22, // Adjust the top position as needed
                        //child: Text('here', style: TextStyle(color: Colors.white)),
                        child: Text('+ ${getSongsAddedByUser(widget.playlist.mixtapes, widget.playlist.target)} songs',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: textScaleFactor * 15,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                    ],
                  ),
                  Positioned(
                    top: screenHeight * .3, // Adjust the top position as needed
                    //child: Text('here', style: TextStyle(color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _searchController,
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
                            hintText: "Search for tapes by...",
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: textScaleFactor * 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: screenSize.shortestSide * .1,
                              ),
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  mixtapes =
                                      mixtapeService.getMixtapesForPlaylistCurrentUser(widget.playlist.id);
                                });
                              },
                            ) // The trailing icon
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: screenHeight * .35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FilledButton(
                            onPressed: () {
                              setState(() {
                                // set state
                                mixtapes = mixtapeService.getMixtapesbyTapeForPlaylistCurrentUser(widget.playlist.id, _searchController.text);
                              });
                            },
                            style: FilledButton.styleFrom(
                                backgroundColor: MixTapeColors.dark_gray,
                                padding: EdgeInsets.all(0),
                                fixedSize: Size(screenWidth * .225, screenWidth * .1)
                            ),
                            child: Text(
                              'Tape Title',
                              style: TextStyle(
                                fontSize: 14 * textScaleFactor,
                                color: MixTapeColors.green,
                              ),
                            ),
                          ),
                          FilledButton(
                            onPressed: () {
                              setState(() {
                                // set state
                                mixtapes = mixtapeService.getMixtapesbySongForPlaylistCurrentUser(widget.playlist.id, _searchController.text);
                              });
                            },
                            style: FilledButton.styleFrom(
                                backgroundColor: MixTapeColors.dark_gray,
                                padding: EdgeInsets.all(0),
                                fixedSize: Size(screenWidth * .225, screenWidth * .1)
                            ),
                            child: Text(
                              'Song Title',
                              style: TextStyle(
                                fontSize: 14 * textScaleFactor,
                                color: MixTapeColors.green,
                              ),
                            ),
                          ),
                          FilledButton(
                            onPressed: () {
                              setState(() {
                                // set state
                                mixtapes = mixtapeService.getMixtapesbyArtistForPlaylistCurrentUser(widget.playlist.id, _searchController.text);
                              });
                            },
                            style: FilledButton.styleFrom(
                                backgroundColor: MixTapeColors.dark_gray,
                                padding: EdgeInsets.all(0),
                                fixedSize: Size(screenWidth * .225, screenWidth * .1)
                            ),
                            child: Text(
                              'Artist',
                              style: TextStyle(
                                fontSize: 14 * textScaleFactor,
                                color: MixTapeColors.green,
                              ),
                            ),
                          ),
                          FilledButton(
                            onPressed: () {
                              setState(() {
                                // set state
                                mixtapes = mixtapeService.getMixtapesbyAlbumForPlaylistCurrentUser(widget.playlist.id, _searchController.text);
                              });
                            },
                            style: FilledButton.styleFrom(
                                backgroundColor: MixTapeColors.dark_gray,
                                padding: EdgeInsets.all(0),
                                fixedSize: Size(screenWidth * .225, screenWidth * .1)
                            ),
                            child: Text(
                              'Album',
                              style: TextStyle(
                                fontSize: 14 * textScaleFactor,
                                color: MixTapeColors.green,
                              ),
                            ),
                          ),
                        ],
                      )
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _refresh,
                      color: MixTapeColors.green,
                      backgroundColor: MixTapeColors.dark_gray,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        // Use SingleChildScrollView instead of ListView
                        child: Column(
                          children: cardData.map((mixtape) {
                            return InkWell(
                              borderRadius: BorderRadius.circular(12.0),
                              onTap: () {
                                print('Tapped on Card ${mixtape.name}');
                                Navigator.of(context).pushReplacementNamed('/tape', arguments: ScreenArguments(widget.playlist, null, null, mixtape));
                              },
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
                                    height: screenHeight * .25,
                                    width: screenWidth * .9,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                          EdgeInsets.fromLTRB(20, 20, 10, 0),
                                          child: Text(
                                            mixtape.name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: (21 * textScaleFactor),
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: screenWidth * .9,
                                          height: screenHeight * .07,
                                          color: MixTapeColors.dark_gray,
                                          child: Card(
                                            elevation: 0.0,
                                            color: MixTapeColors.dark_gray,
                                            child: ListTile(
                                              leading: Image.asset(
                                                'assets/blue_colored_logo.png',
                                                width: screenWidth * .1,
                                                height: screenHeight * .1,
                                              ),
                                              title: Text(
                                                mixtape.songs[0].name,
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                  fontSize: textScaleFactor * 13,
                                                ),
                                              ),
                                              subtitle: Text(
                                                "${mixtape.songs[0].artistNames[0]} • ${mixtape.songs[0].albumName}",
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
                                        if (mixtape.songs.length > 1)
                                          SizedBox(
                                            height: screenHeight * .01,
                                          ),
                                        if (mixtape.songs.length > 1)
                                          Container(
                                            width: screenWidth * .9,
                                            height: screenHeight * .07,
                                            color: MixTapeColors.dark_gray,
                                            child: Card(
                                              elevation: 0.0,
                                              color: MixTapeColors.dark_gray,
                                              child: ListTile(
                                                leading: Image.asset(
                                                  'assets/blue_colored_logo.png',
                                                  width: screenWidth * .1,
                                                  height: screenHeight * .1,
                                                ),
                                                title: Text(
                                                  mixtape.songs[1].name,
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                    fontSize: textScaleFactor * 13,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  "${mixtape.songs[1].artistNames[0]} • ${mixtape.songs[1].albumName}",
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
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                screenWidth * .64, 0, 0, 0),
                                            child: FloatingActionButton.extended(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    15), // Adjust the radius as needed
                                              ),
                                              heroTag: "mixtape_creation",
                                              onPressed: () async {
                                                // print("add to queue");
                                                try {
                                                  await mixtapeService.enqueueMixtape(mixtape.playlistId, mixtape.id);
                                                } on FormatException {
                                                  final snackBar = SnackBar(
                                                    content: Text("Mixtape successfully queued")
                                                  );
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                } catch (e) {
                                                  print(e);
                                                  final snackBar = SnackBar(
                                                    content: Text("Error queueing, please ensure you have Spotify open")
                                                  );
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                }
                                              },
                                              label: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    1, 1, 1, 1),
                                                child: Text(
                                                  'Queue',
                                                  style: TextStyle(
                                                    fontSize:
                                                    textScaleFactor * 15,
                                                    fontFamily: "Montserrat",
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              backgroundColor: MixTapeColors
                                                  .green, // Change the button's color
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
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * .05),
                    child: FloatingActionButton.extended(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Adjust the radius as needed
                      ),
                      heroTag: "mixtape_creation",
                      onPressed: () {
                        print("create mixtape");
                        Navigator.of(context).pushNamed('/tapecreate', arguments: ScreenArguments(widget.playlist));
                      },
                      label: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Add a MixTape',
                          style: TextStyle(
                            fontSize: textScaleFactor * 20,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      icon: Icon(Icons.add, color: Colors.white),
                      backgroundColor:
                      MixTapeColors.green, // Change the button's color
                    ),
                  ),
                ],
              ),
            );
          }),
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

  int getSongsAddedByUser(List<Mixtape> mixtapes, Profile profile) {
    print(mixtapes.length);
    int total = 0;
    for(Mixtape mixtape in mixtapes) {
      if(mixtape.creator.displayName == profile.displayName) {
        total += mixtape.songs.length;
      }
    }
    print(total);
    return total;
  }

}