import 'package:flutter/material.dart';
import 'package:mixtape/screens/home_page.dart';
import 'package:mixtape/screens/login_page.dart';
import 'package:mixtape/utilities/navbar_pages.dart';
import 'package:mixtape/widgets/navbar.dart';

import '../utilities/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NavbarPages.navBarPages.elementAt(_selectedIndex)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      backgroundColor: MixTapeColors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * .01),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0 * textScaleFactor,
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
                            image: AssetImage('assets/ish_profile_picture.png'),
                          ))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.width * .01),
                  child: Text(
                    'ish mistry',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0 * textScaleFactor,
                    ),
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
                  showAlertDialog(context, textScaleFactor);
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
                        child: Text(
                          'Logout',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20.0 * textScaleFactor,
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
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  showAlertDialog(BuildContext context, double textScaleFactor) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
          "Cancel",
        style: TextStyle(color: MixTapeColors.green, fontSize: textScaleFactor * 16)
      ),
      onPressed:  () {
        Navigator.pop(context, 'Cancel');
      },
    );
    Widget continueButton = TextButton(
      child: Text("Logout",
          style: TextStyle(color: MixTapeColors.green, fontSize: textScaleFactor * 16)
    ),
      onPressed:  () {
        const snackBar = SnackBar(
          content: Text('Successfully Logged Out'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: MixTapeColors.dark_gray,
      title: Text("Are you sure you would like to log out?",
      style: TextStyle(color: Colors.white, fontSize: textScaleFactor * 20)),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
