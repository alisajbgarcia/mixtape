import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

class TapeInfoScreen extends StatefulWidget {
  final int tape_id;
  final int spotify_id;
  const TapeInfoScreen({required this.tape_id, required this.spotify_id});

  @override
  State<TapeInfoScreen> createState() => _TapeInfoScreenState();
}

class _TapeInfoScreenState extends State<TapeInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MixTapeColors.black,
      body: Center(child: Text("Tape Info Screen")),
    );
  }
}
