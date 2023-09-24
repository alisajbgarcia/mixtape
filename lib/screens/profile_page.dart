import 'package:flutter/material.dart';

import '../utilities/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MixTapeColors.black,
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 9,
            child: Column(
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold),
                ),
                // Profile picture, using MixTape logo temporarily until Spotify Link
                Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/green_colored_logo.png'),
                        ))),
              ],
            ),
          ),
          Flexible(
            flex: 5,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                foregroundColor:
                    MaterialStateProperty.all<Color>(MixTapeColors.green),
              ),
              onPressed: () {
                print("logout");
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/spotify/Spotify_Icon_RGB_Green.png',
                    width: 100,
                    height: 100,
                  ),
                  const Text(
                    'Logout',
                    style: TextStyle(fontFamily: 'Montserrat'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
