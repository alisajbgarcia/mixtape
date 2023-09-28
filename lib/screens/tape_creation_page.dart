import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/widgets/navbar.dart';

import '../utilities/navbar_pages.dart';

class TapeCreationPage extends StatefulWidget {
  const TapeCreationPage({super.key});

  @override
  _TapeCreationPageState createState() => _TapeCreationPageState();
}

class TapeInfo {
  String title;
  String message;
  List songs;

  TapeInfo(this.title, this.message, this.songs);
}

class _TapeCreationPageState extends State<TapeCreationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MixTapeColors.black,
      body: Text("tape creation placeholder",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white)),
    );
  }
}
