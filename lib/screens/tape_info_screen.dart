import 'package:flutter/material.dart';
import 'package:mixtape/models/track_info.dart';
import 'package:mixtape/models/mixtape.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/services/mixtape_service.dart';
import 'package:mixtape/services/authentication_service.dart';
import 'package:mixtape/services/services_container.dart';


class TapeInfoScreen extends StatefulWidget {
  final String playlist_id;
  final String tape_id;
  final String spotify_id;
  final String title;
  final List<TrackInfo> songs;
  final List<Reaction> reactions;
  final String description;
  const TapeInfoScreen(
      { required this.playlist_id,
      required this.tape_id,
      required this.spotify_id,
      required this.title,
      required this.songs,
      required this.reactions,
      required this.description});

  @override
  State<TapeInfoScreen> createState() => _TapeInfoScreenState();
}

class _TapeInfoScreenState extends State<TapeInfoScreen> {
  late AuthenticationService authenticationService;
  late MixtapeService mixtapeService;

  Icon getIconForReaction(ReactionType type) {
    switch (type) {
      case ReactionType.LIKE:
        return Icon(Icons.thumb_up, color: Colors.white,);
      case ReactionType.DISLIKE:
        return Icon(Icons.thumb_down, color: Colors.white,);
      case ReactionType.HEART:
        return Icon(Icons.favorite, color: Colors.pinkAccent,);
      case ReactionType.FIRE:
        return Icon(Icons.whatshot, color: Colors.red,);
    }
  }

  @override
  void initState() {
    super.initState();
    mixtapeService = ServicesContainer.of(context).mixtapeService;
    authenticationService = ServicesContainer.of(context).authService;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
        backgroundColor: MixTapeColors.black,
        body: Container(
          width: screenWidth,
          height: screenHeight,
          color: MixTapeColors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                    child: Image.asset(
                      'assets/mixtape_image.png',
                      scale: 1.01,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top:
                        screenHeight * .06, // Adjust the top position as needed
                    child: Center(
                      child: Container(
                        height: screenHeight * .05, // Set
                        width: screenWidth * .55,
                        decoration: BoxDecoration(
                          color: MixTapeColors.black.withOpacity(
                              .5), // Set the background color to gray
                          borderRadius:
                              BorderRadius.circular(3), // Add rounded corners
                        ),
                        child: FittedBox(
                          fit: BoxFit
                              .scaleDown, // This makes the text shrink to fit
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(children: [
                              Text(
                                widget.title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top:
                    screenHeight * .22, // Adjust the top position as needed
                    child: Center(
                      child: Container(
                        height: screenHeight * .06, // Set
                        width: screenWidth * .55,
                        decoration: BoxDecoration(
                          color: MixTapeColors.black.withOpacity(
                              .5), // Set the background color to gray
                          borderRadius:
                          BorderRadius.circular(3), // Add rounded corners
                        ),
                        child: FittedBox(
                          fit: BoxFit
                              .scaleDown, // This makes the text shrink to fit
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Column(children: [
                              Text(
                                widget.description,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: screenHeight * .05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ReactionType.values.map((type) {
                      return IconButton(
                        icon: getIconForReaction(type),
                        onPressed: () {
                         mixtapeService.addReactionForCurrentUser(widget.playlist_id, widget.tape_id, type: type.toString()).then((_) {
                           setState(() {
                             // set the state
                           });
                         });
                         print("reaction added");
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Reactions:',
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    children: widget.reactions.map((reaction) {
                      return ListTile(
                        leading: getIconForReaction(reaction.reactionType),
                        title: Text('${reaction.reactor.displayName} reacted with ${reaction.reactionType.toString()}'),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: widget.songs.map((song) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12.0), // Adjust the radius as needed
                          ),
                          elevation: 0.0,
                          color: MixTapeColors.dark_gray,
                          margin: EdgeInsets.all(15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Container(
                              color: MixTapeColors.dark_gray,
                              height: screenHeight * .1,
                              width: screenWidth * .9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: screenWidth * .9,
                                    height: screenHeight * .07,
                                    color: MixTapeColors.dark_gray,
                                    child: Card(
                                      elevation: 0.0,
                                      color: MixTapeColors.dark_gray,
                                      child: ListTile(
                                        title: Text(
                                          song.name,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: textScaleFactor * 16,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "${song.artistNames[0]} • ${song.albumName}",
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            fontSize: textScaleFactor * 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.only(top: 200),
//           child: Column(children: [
//             Text(widget.title, style: TextStyle(color: Colors.white)),
//             Image.asset(
//               widget.image,
//               width: screenWidth * .4,
//               height: screenHeight * .4,
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 // Use SingleChildScrollView instead of ListView
//                 child: Column(
//                     children: widget.songs.map((song) {
//                   return Text(song.title,
//                       style: TextStyle(color: Colors.white));
//                 }).toList()),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
