import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/screens/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
        backgroundColor: MixTapeColors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/green_colored_logo.png',
                width: screenHeight * .4,
                height: screenHeight * .4,
              ),
              SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () {
                  print("login");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: MixTapeColors.dark_gray,
                  padding: EdgeInsets.all(10),
                  fixedSize: Size(screenWidth * .75, screenWidth * .25),
                ),
                icon: Image.asset(
                  'assets/spotify/Spotify_Icon_RGB_Green.png',
                  width: screenSize.shortestSide * .1,
                  height: screenSize.shortestSide * .1,
                  alignment: Alignment.centerLeft,
                ),
                label: Text(
                  'Login with Spotify',
                  style: TextStyle(
                    fontSize: 20 * textScaleFactor,
                    color: MixTapeColors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ));
  }
}
