import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MixTapeColors.black,
      body: Column(
        children: <Widget>[
          Image.asset('assets/green_colored_logo.png',
            fit: BoxFit.scaleDown,
          ),
          FilledButton.icon(onPressed: null,
            style: FilledButton.styleFrom(
            backgroundColor: MixTapeColors.dark_gray,
            padding: EdgeInsets.all(10),
            fixedSize: Size(250, 100),
          ),
            icon: Image.asset('assets/spotify/Spotify_Icon_RGB_Green.png',
                width: 35,
                height: 35,
              alignment: Alignment.centerLeft,
            ),
            label: Text('Login with Spotify',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
