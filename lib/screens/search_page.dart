import 'package:flutter/material.dart';
import 'package:mixtape/models/SongInfo.dart';
import 'package:mixtape/utilities/colors.dart';
import 'dart:convert';
import 'package:spotify/spotify.dart';

// class Song {
//   String title;
//   String artist;
//   String album;
//
//   Song(this.title, this.artist, this.album);
// }

SpotifyApiCredentials credentials = SpotifyApiCredentials("df9bd9e5ec41469baf91e29921d605a9", "1f740b22a8984436bb87e41d7fa23295");
SpotifyApi spotify = SpotifyApi(credentials);

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<SongInfo> _searchResults = [];

  void searchSpotify(String query) async {
    var search = await spotify.search.get(query).first(5);

    _searchResults = [];

    search.forEach((pages) {
      pages.items!.forEach((item) {
        if (item is Track) {
          _searchResults.add(SongInfo(item.name!,
              item.artists!.first.name!,
              item.album!.name!,
              item.duration!.inSeconds.toDouble()));
        }
      });
    });
  }

  void searchSpotifybyAlbum(String query) async {
    var search = await spotify.search.get(query).first(5);

    _searchResults = [];

    search.forEach((pages) {
      pages.items!.forEach((item) {
        if (item is Track) {
          _searchResults.add(SongInfo(item.name!,
              item.artists!.first.name!,
              item.album!.name!,
              item.duration!.inSeconds.toDouble()));
        }
      });
    });
  }

  void searchSpotifybyArtist(String query) async {
    var search = await spotify.search.get(query).first(5);

    _searchResults = [];

    search.forEach((pages) {
      pages.items!.forEach((item) {
        if (item is Track) {
          _searchResults.add(SongInfo(item.name!,
              item.artists!.first.name!,
              item.album!.name!,
              item.duration!.inSeconds.toDouble()));
        }
      });
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
      body: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Filter by")],
          ),
          Padding(
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
                hintText: "Search for songs by...",
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
                  onPressed: () => setState(() {
                    _searchController.clear;
                    _searchResults = [];
                  })
                ) // The trailing icon
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton(
                onPressed: () => setState(() {
                    searchSpotify(_searchController.text);
                  }
                ),
                style: FilledButton.styleFrom(
                    backgroundColor: MixTapeColors.dark_gray,
                    padding: EdgeInsets.all(0),
                    fixedSize: Size(screenWidth * .25, screenWidth * .1)
                ),
                child: Text(
                  'Song Name',
                  style: TextStyle(
                    fontSize: 14 * textScaleFactor,
                    color: MixTapeColors.green,
                  ),
                ),
              ),
              FilledButton(
                onPressed: () => setState(() =>
                _searchResults = [
                  SongInfo("Always", "Daniel Caesar", "NEVER ENOUGH", 222),
                  SongInfo("Blessed", "Daniel Caesar", "Freudian", 189),
                  SongInfo("Do You Like Me?", "Daniel Caesar", "NEVER ENOUGH", 193),
                  SongInfo("Let Me Go", "Daniel Caesar", "NEVER ENOUGH", 130),
                  SongInfo("Loose", "Daniel Caesar", "Freudian", 201),
                ]
                ),
                style: FilledButton.styleFrom(
                    backgroundColor: MixTapeColors.dark_gray,
                    padding: EdgeInsets.all(0),
                    fixedSize: Size(screenWidth * .25, screenWidth * .1)
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
                onPressed: () => setState(() =>
                _searchResults = [
                  SongInfo("The Color Violet", "Torey Lanez", "Alone At Prom", 233),
                  SongInfo("Ballad of a Badman", "Torey Lanez", "Alone At Prom", 221),
                  SongInfo("\'87 Stingray", "Torey Lanez", "Alone At Prom", 287),
                  SongInfo("Pluto's Last Comet", "Torey Lanez", "Alone At Prom", 193),
                  SongInfo("Lady of Namek", "Torey Lanez", "Alone At Prom", 174),
                ]
                ),
                style: FilledButton.styleFrom(
                    backgroundColor: MixTapeColors.dark_gray,
                    padding: EdgeInsets.all(0),
                    fixedSize: Size(screenWidth * .25, screenWidth * .1)
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
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _searchResults.map((song) {
                  return InkWell(
                    onTap: () {
                      print("Clicked on ${song.title}");
                      Navigator.pop(context, song);
                    },
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
            ),
          ),
        ],
      ),
    );
  }
}
