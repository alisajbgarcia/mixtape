import 'package:flutter/material.dart';
import 'package:mixtape/screens/home_page.dart';

import '../utilities/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // int _selectedIndex = 0;
  //
  // static List<Widget> _pages = <Widget>[
  //   HomePage(),
  //   ProfilePage(),
  //   ProfilePage(),
  // ];
  //
  // void _onItemTapped(int index) {
  //   Navigator.of(context as BuildContext).push(
  //     MaterialPageRoute(builder: (context) => _pages.elementAt(_selectedIndex)),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MixTapeColors.black,
      // appBar: AppBar(
      //   backgroundColor: MixTapeColors.black,
      //   title: Text('Profile Page'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Flexible(
          //   flex: 1,
          //   child: Align(
          //     alignment: Alignment.topRight,
          //     child: IconButton(
          //     icon: const Icon(Icons.settings),
          //     onPressed: () {
          //       print("settings");
          //     },
          //   ),),
          // ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                ),
                // Profile picture, using MixTape logo temporarily until Spotify Link
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width * .5,
                      height: MediaQuery.of(context).size.width * .5,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/green_colored_logo.png'),
                          ))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: const Text(
                    'ish mistry',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .1,
                  right: MediaQuery.of(context).size.width * .1),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  fixedSize: MaterialStateProperty.all(Size.fromHeight(
                      MediaQuery.of(context).size.height * .12)),
                  padding: MaterialStateProperty.all(EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .05,
                      right: MediaQuery.of(context).size.width * .05)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
                onPressed: () {
                  print("logout");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        'assets/spotify/Spotify_Icon_RGB_Green.png',
                        width: 50,
                        height: 100,
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Center(
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: MixTapeColors.green,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Tab 1',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Tab 2',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle_rounded),
      //       label: 'Profile',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.blue,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
