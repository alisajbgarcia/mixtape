import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

List<Widget> _tutorialPages = <Widget>[
  // playlist creation
  Padding(
    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
    child: Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Playlist Creation',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize:30,
              ),
            ),
            Text(
              'This is the playlist creation screen. Choose a photo, title, and friend for your playlist. \n\n'
              'Click the \"Invite\" button to send an invitation. Your friend must accept the invite for the playlist to be created',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize:15,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  'assets/playlist_creation.png',
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "1 of 4",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        "Swipe",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
  // playlist info
  Padding(
    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
    child: Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Playlist Screen',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize:30,
              ),
            ),
            Text(
              'This is the playlist info screen. View playlist statistics and a list of all MixTapes. \n\n'
                  'Click the \"Add a MixTape\" button to add one to the playlist. Your friend will receive a notification.\n'
              'Click the \"Queue\" button to add a MixTape to your Spotify queue.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize:15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22, 0, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  'assets/playlist_info.png',
                  height: 375,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "2 of 4",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        "Swipe",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
  // mixtape creation
  Padding(
    padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
    child: Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'MixTape Creation',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize:30,
              ),
            ),
            Text(
              'This is the MixTape creation screen. A MixTape is a collection of songs you want to share.\n'
                  'Customize your Tape by adding a name and description.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: Colors.white,
                fontSize:15,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/create_mixtape.png',
                height: 375,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "3 of 4",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Text(
                        "Swipe",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
  // add songs
  Container(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.fromLTRB(8, 30, 8, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Add Songs',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize:30,
            ),
          ),
          Text(
            'This is the song search screen. Search songs from Spotify to add to your MixTape.\n'
                'Filter results by name, artist, or album.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize:15,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/add_songs.png',
              height: 375,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "4 of 4",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Text(
                      "Swipe",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 45,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Get Started",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Icon(
                Icons.arrow_downward_rounded,
                color: Colors.white,
                size: 40,
              ),
            ],
          ),
        ],
      ),
    ),
  ),

];

class PlaylistMixtapeTutorialPages extends StatefulWidget {
  const PlaylistMixtapeTutorialPages({super.key});

  @override
  State<PlaylistMixtapeTutorialPages> createState() => _PlaylistMixtapeTutorialPagesState();
}

class _PlaylistMixtapeTutorialPagesState extends State<PlaylistMixtapeTutorialPages> {
  PageController _pageController = PageController();
  int _curr = 0;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Container(
      padding: EdgeInsets.fromLTRB(0, screenHeight * .25, 0, 0),
      height: screenHeight,
      child: PageView(
        allowImplicitScrolling: true,
        children: _tutorialPages,
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        onPageChanged: (num) {
          setState(() {
            _curr = num;
          });
        },
      ),
    );
  }
}
