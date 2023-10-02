import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/screens/tape_creation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<String> searchResults = [];

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
        searchResults =
            tracks.map((track) => (track['name']) as String).toList();
      });
    } else {
      // Handle API error here
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
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 15,
                ), // The trailing icon
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
                onPressed: () {
                  // Add your button's action here
                },
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
                onPressed: () {
                  // Add your button's action here
                },
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
                onPressed: () {
                  // Add your button's action here
                },
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
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(searchResults[index]),
                  onTap: () {
                    addToTape(searchResults[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
