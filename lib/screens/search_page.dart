import 'package:flutter/material.dart';
import 'package:mixtape/models/SongInfo.dart';
import 'package:mixtape/utilities/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// class Song {
//   String title;
//   String artist;
//   String album;
//
//   Song(this.title, this.artist, this.album);
// }

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<SongInfo> _searchResults = [];

  void searchSpotify(String query) async {
    // just here for proof of concept. obviously not using this
    String apiKey = 'placeholder';
    String apiUrl = 'https://api.spotify.com/v1/search?q=$query&type=track';

    var response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': 'Bearer $apiKey'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> tracks = data['tracks']['items'];

      setState(() {
        // nothin
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  void addToTape(String song) {
    // TODO
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
                  onPressed: _searchController.clear,
                ) // The trailing icon
              ),
              onChanged: (value) {
                searchSpotify(value);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FilledButton(
                onPressed: () => setState(() =>
                  _searchResults = [
                    SongInfo("Heartless", "Kanye West", "808s & Heartbreak"),
                    SongInfo("Heart to Heart", "Mac Demarco", "Here Comes The Cowboy"),
                    SongInfo("Heartbeat", "Childish Gambino", "Camp"),
                    SongInfo("Heartless", "The Weeknd", "After Hours"),
                    SongInfo("Heartbreak Anniversary", "Giveon", "Heartbreak Anniversary"),
                  ]
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
                  SongInfo("Always", "Daniel Caesar", "NEVER ENOUGH"),
                  SongInfo("Blessed", "Daniel Caesar", "Freudian"),
                  SongInfo("Do You Like Me?", "Daniel Caesar", "NEVER ENOUGH"),
                  SongInfo("Let Me Go", "Daniel Caesar", "NEVER ENOUGH"),
                  SongInfo("Loose", "Daniel Caesar", "Freudian"),
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
                  SongInfo("The Color Violet", "Torey Lanez", "Alone At Prom"),
                  SongInfo("Ballad of a Badman", "Torey Lanez", "Alone At Prom"),
                  SongInfo("\'87 Stingray", "Torey Lanez", "Alone At Prom"),
                  SongInfo("Pluto's Last Comet", "Torey Lanez", "Alone At Prom"),
                  SongInfo("Lady of Namek", "Torey Lanez", "Alone At Prom"),
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
