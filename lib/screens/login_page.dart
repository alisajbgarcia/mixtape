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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/green_colored_logo.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              FilledButton.icon(
                onPressed: null,
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  fixedSize: Size(250, 100),
                ),
                icon: Image.asset(
                  'assets/spotify/Spotify_Icon_RGB_Green.png',
                  width: 35,
                  height: 35,
                  alignment: Alignment.centerLeft,
                ),
                label: Text(
                  'Login with Spotify',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ));
  }
}
