import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mixtape/utilities/navbar_pages.dart';
import 'package:mixtape/widgets/navbar.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import '../services/oauth2_service.dart';
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
      MaterialPageRoute(
          builder: (context) =>
              NavbarPages.navBarPages.elementAt(_selectedIndex)),
    );
  }

  Future<Response> getAuth() async {
    OAuth2Client client = SpotifyOAuth2Client(
        redirectUri: "com.mixtape//callback", customUriScheme: "com.mixtape");

//Then, instantiate the helper passing the previously instantiated client
    OAuth2Helper oauth2Helper = OAuth2Helper(client,
        grantType: OAuth2Helper.authorizationCode,
        clientId: 'spotify-client',
        clientSecret: 'secret',
        scopes: ['profile', 'openid']);
//
    Response res = await oauth2Helper
        .get('http://localhost:8080/api/v1/profile/me') as Response;
//     Response res = await get(Uri.parse('http://localhost:8080/api/v1/profile/me'));
//     Response res = await get(Uri.parse('http://localhost:9000/login'));
    // print(jsonDecode(res.body));
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

//     OAuth2Client client = SpotifyOAuth2Client(
//         redirectUri: "com.mixtape//callback", customUriScheme: "com.mixtape");
//
// //Then, instantiate the helper passing the previously instantiated client
//     OAuth2Helper oauth2Helper = OAuth2Helper(client,
//         grantType: OAuth2Helper.authorizationCode,
//         clientId: 'spotify-client',
//         clientSecret: 'secret',
//         scopes: ['profile', 'openid']);

    return Scaffold(
      backgroundColor: MixTapeColors.black,
      body: FutureBuilder(
        future: getAuth(),
        builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.width * .01),
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
                                  image: AssetImage(
                                      'assets/green_colored_logo.png'),
                                ))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * .01),
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
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
