import 'package:flutter/material.dart';
import 'package:mixtape/models/PlaylistInfo.dart';
import 'package:mixtape/screens/home_page.dart';
import 'package:mixtape/screens/playlist_screen.dart';
import 'package:mixtape/screens/search_page.dart';

import '../models/SongInfo.dart';
import '../utilities/colors.dart';

class AddSongsPage extends StatefulWidget {
  final PlaylistInfo playlist;
  final String mixTapeName;
  final String mixTapeDescription;
  const AddSongsPage({
    required this.playlist,
    required this.mixTapeName,
    required this.mixTapeDescription,
  });

  @override
  State<AddSongsPage> createState() => _AddSongsPageState();
}

class _AddSongsPageState extends State<AddSongsPage> {
  List<SongInfo> _addedSongs = <SongInfo>[];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // _addedSongs.add(new Song("Monster", "Eminem", "Album"));
    return Scaffold(
      backgroundColor: MixTapeColors.black,
      body: Container(
        width: screenWidth,
        height: screenHeight,
        color: MixTapeColors.black,
        child: Padding(
          padding: EdgeInsets.fromLTRB(screenWidth * .01, screenHeight * .1,
              screenWidth * .01, screenHeight * .05),
          child: Column(children: [
            Text(
              "Add Songs to ${widget.mixTapeName}",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontFamily: "Montserrat", fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * .1,
                      screenHeight * .05, screenWidth * .1, screenHeight * .05),
                  child: Column(children: [
                    Column(
                      children: _addedSongs.map((song) {
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
                                            song.title,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                              fontSize: textScaleFactor * 16,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "${song.artist} • ${song.album}",
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
                    FloatingActionButton.extended(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15), // Adjust the radius as needed
                      ),
                      heroTag: "submit_mixtape_creation",
                      onPressed: () {
                        //comment this out when finish implementing
                        // setState(() {
                        //   _addedSongs.add(SongInfo("Song", "Artist", "Album"));
                        // });
                        // Comment up to here

                        // Uncomment the following (untested)
                        _addSongFromSearchPage(context);
                      },
                      label: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          'Add Song',
                          style: TextStyle(
                            fontSize: textScaleFactor * 20,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      icon: Icon(Icons.add),
                      backgroundColor:
                          MixTapeColors.dark_gray, // Change the button's color
                    ),
                  ]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, screenHeight * .03, 0, 0),
              child: FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Adjust the radius as needed
                ),
                heroTag: "submit_mixtape_creation",
                onPressed: () {
                  MixTapeInfo mixTape = MixTapeInfo(widget.mixTapeName, "", _addedSongs.length, _addedSongs, widget.mixTapeDescription);
                  print("Title: ${mixTape.title}, NumSongs: ${mixTape.numSongs}, Description: ${mixTape.description}");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(),));
                },
                label: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    'Send MixTape',
                    style: TextStyle(
                      fontSize: textScaleFactor * 20,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                icon: Icon(Icons.send),
                backgroundColor:
                    MixTapeColors.green, // Change the button's color
              ),
            ),
          ]),
        ),
      ),
    );
  }


  // FINISH IMPLEMENTATION ONCE ISH'S SCREEN IS MERGED IN
  // TODO: HAVEN'T TESTED, EXPECTS THAT SEARCH SCREEN WILL EXECUTE Navigator.pop(context, Song(title, artist, album)); WHEN ADDING SONG
  Future<void> _addSongFromSearchPage(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final pickedSong = await Navigator.push(
      context,
      // MAY NEED TO ADD PARAMETERS
      MaterialPageRoute(builder: (context) => const SearchPage()),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;


    if (pickedSong != null && pickedSong is SongInfo) {
      setState(() {
        _addedSongs.add(pickedSong);
      });
    }
  }
}
