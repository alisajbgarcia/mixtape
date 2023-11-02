import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mixtape/utilities/colors.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class ImageUpload extends StatefulWidget {
  final Function(XFile) photoFile;
  String photoURL;
  ImageUpload({required this.photoFile, required this.photoURL});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  String playlistPhoto = "";
  XFile? imageFile;

  // converts image asset to XFile type
  getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');
    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    setState(() {
      playlistPhoto = file.path;
      imageFile = XFile(playlistPhoto);
      widget.photoFile(imageFile!);
      widget.photoURL = playlistPhoto;
    });
    return playlistPhoto;
  }

  _pickImagefromGallery() async {
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageFile = XFile(pickedImage.path);
          playlistPhoto = pickedImage.path;
          this.widget.photoFile(imageFile!);
          widget.photoURL = playlistPhoto;
        });
        return playlistPhoto;
      } else {
        print('User didnt pick any image.');
        
      }
    } catch (e) {
      //print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return AlertDialog(
      backgroundColor: MixTapeColors.black,
      title: Text(
        'Choose a photo for your playlist',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w600,
          fontSize: textScaleFactor * 18,
        ),
      ),
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth * .01),
                  child: Container(
                    width: screenWidth * .25,
                    height: screenHeight * .05,
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: MixTapeColors.light_gray,
                      onPressed: () async {
                        print('image upload dialog');
                        playlistPhoto = await _pickImagefromGallery();
                        widget.photoFile(imageFile!);
                        //Navigator.of(context).pop();
                      },
                      child: Text(
                        'Upload',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: textScaleFactor * 15,
                        ),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(screenWidth * .01),
                  child: Container(
                    width: screenWidth * .25,
                    height: screenHeight * .05,
                    child: FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: MixTapeColors.light_gray,
                      onPressed: () async {
                        print('image default');
                        playlistPhoto = await getImageFileFromAssets('blue_colored_logo.png');
                        widget.photoFile(imageFile!);
                      },
                      child: Text(
                        'Default',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: textScaleFactor * 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: screenHeight * .04),

            Container(
              height: screenHeight * .17,
              color: MixTapeColors.dark_gray,
              child: widget.photoURL.length > 0 || playlistPhoto.length > 0 ?
              Image(
                image: FileImage(File(widget.photoURL)),
                width: screenWidth * .4,
                height: screenWidth * .4,
                fit: BoxFit.cover,
              ) :
              Container(
                width: screenWidth * .4,
                height: screenWidth * .4,
              ),
            ),


          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: screenWidth * .2,
            height: screenHeight * .05,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              backgroundColor: MixTapeColors.green,
              onPressed: () {
                print(playlistPhoto.length);
                if(widget.photoURL.length == 0) {
                  widget.photoFile(imageFile!);
                }
                Navigator.of(context).pop();
              },
              child: Text(
                'Done',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: textScaleFactor * 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
