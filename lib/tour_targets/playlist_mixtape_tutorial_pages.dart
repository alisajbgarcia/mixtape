import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

final List<Widget> _tutorialPages = <Widget>[
  // playlist creation
  Container(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize:30,
            ),
          ),
          Text(
            'This is the profile page. Your MixTape account is linked to your Spotify account.\n'
                'You will be able to add a collection of songs from playlist MixTapes to your queue.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize:17,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/profile_page.png',
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    ),
  ),
  // mixtape creation
  Container(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize:30,
            ),
          ),
          Text(
            'This is the profile page. Your MixTape account is linked to your Spotify account.\n'
                'You will be able to add a collection of songs from playlist MixTapes to your queue.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize:17,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/profile_page.png',
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    ),
  ),
  // add songs
  Container(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize:30,
            ),
          ),
          Text(
            'This is the profile page. Your MixTape account is linked to your Spotify account.\n'
                'You will be able to add a collection of songs from playlist MixTapes to your queue.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize:17,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/profile_page.png',
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    ),
  ),
  // playlist info, queueing
  Container(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize:30,
            ),
          ),
          Text(
            'This is the profile page. Your MixTape account is linked to your Spotify account.\n'
                'You will be able to add a collection of songs from playlist MixTapes to your queue.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize:17,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/profile_page.png',
              height: 100,
              fit: BoxFit.cover,
            ),
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
      height: screenHeight * .7,
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
