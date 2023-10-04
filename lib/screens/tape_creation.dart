import 'package:flutter/material.dart';
import 'package:mixtape/screens/add_songs.dart';

import '../utilities/colors.dart';

class TapeCreationScreen extends StatefulWidget {
  final int playlistId;
  final String title;
  final String image;
  const TapeCreationScreen({
    required this.playlistId,
    required this.title,
    required this.image,
  });

  @override
  State<TapeCreationScreen> createState() => _TapeCreationScreenState();
}

class _TapeCreationScreenState extends State<TapeCreationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: MixTapeColors.black,
        body: Container(
          width: screenWidth,
          height: screenHeight,
          color: MixTapeColors.black,
          child: Padding(
            padding: EdgeInsets.fromLTRB(screenWidth * .01, screenHeight * .1, screenWidth * .01, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Create a MixTape", style: TextStyle(
                color: Colors.white, fontFamily: "Montserrat", fontSize: 35, fontWeight: FontWeight.bold),),
                SizedBox(height: screenHeight * .01),
                Text("This mixtape will be added to ${widget.title}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    color: Colors.white, fontFamily: "Montserrat", fontSize: 15,),),
                SizedBox(height: screenHeight * .01),
                Image.asset(widget.image,
                  height: screenHeight * .1,
                  width: screenHeight * .1,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenWidth * .05,
                            screenHeight * .05,
                            screenWidth * .05,
                            screenHeight * .05),
                        child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "MixTape Name",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
                                        fontSize: 25),
                                  ),
                                  SizedBox(height: screenHeight * .01),
                                  TextFormField(
                                    controller: nameController,
                                    cursorColor: MixTapeColors.green,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: MixTapeColors.light_gray,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide: BorderSide(
                                            color: MixTapeColors.light_gray),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide: BorderSide(
                                            color: MixTapeColors.green),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a MixTape name';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: screenHeight * .03),
                                  Text(
                                    "MixTape Description",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
                                        fontSize: 25),
                                  ),
                                  SizedBox(height: screenHeight * .01),
                                  TextFormField(
                                    controller: descriptionController,
                                    cursorColor: MixTapeColors.green,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: MixTapeColors.light_gray,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide: BorderSide(
                                            color: MixTapeColors.green),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide: BorderSide(
                                            color: MixTapeColors.green),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a description';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0, screenHeight * .03, 0, 0),
                                    child: FloatingActionButton.extended(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            15), // Adjust the radius as needed
                                      ),
                                      heroTag: "submit_mixtape_creation",
                                      onPressed: () {
                                        print("create mixtape");
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(
                                          //   const SnackBar(
                                          //       content: Text('MixTape Created')),
                                          // );
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddSongsPage(
                                                          playlistId:
                                                              widget.playlistId,
                                                          mixTapeName:
                                                              nameController
                                                                  .text,
                                                          mixTapeDescription:
                                                              descriptionController
                                                                  .text)));
                                        }
                                      },
                                      label: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Text(
                                          'Add Songs',
                                          style: TextStyle(
                                            fontSize: textScaleFactor * 20,
                                            fontFamily: "Montserrat",
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      icon: Icon(Icons.add),
                                      backgroundColor: MixTapeColors
                                          .green, // Change the button's color
                                    ),
                                  ),
                                ]))),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
