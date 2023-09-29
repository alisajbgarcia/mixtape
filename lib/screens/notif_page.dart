import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/widgets/navbar.dart';

import '../utilities/navbar_pages.dart';

class NotifPage extends StatefulWidget {
  @override
  _NotifPage createState() => _NotifPage();
}

class NotifInfo {
  String type;
  String user;
  String title;

  NotifInfo(this.type, this.user, this.title);
}


class _NotifPage extends State<NotifPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NavbarPages.navBarPages.elementAt(_selectedIndex)),
    );
  }

  List<NotifInfo> notifInfo = [
    NotifInfo('friend', 'alexfrey', ''),
    NotifInfo('playlist', 'charlie', 'Party Time'),
    NotifInfo('friend', 'bruh', ''),

  ];


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
      backgroundColor: MixTapeColors.black,
      appBar: AppBar(
        title: Text('Notifications',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: (25.0 * textScaleFactor),
          ),
        ),
        backgroundColor: MixTapeColors.black,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        toolbarHeight: screenHeight * .13,
      ),
      body: Column(
        children: notifInfo.map((notif) {
          return InkWell(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
              ),
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: notif.type.contains('friend') //Is it a friend or playlist notification
                ? Container(//Friend
                  color: MixTapeColors.dark_gray,
                  padding: EdgeInsets.all(9.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          softWrap: true,
                          style: TextStyle(
                            fontSize: (15 * textScaleFactor),
                            color: Colors.white,
                            fontFamily: "Montserrat",
                          ),
                        '${notif.user} would like to be your friend, do you accept?'
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(10),
                        icon: ImageIcon(
                          AssetImage("assets/yes.png"),
                          size: textScaleFactor * 50,
                          color: Colors.white,
                        ),
                        onPressed: () => setState(() => notifInfo.remove(notif)),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(10),
                        icon: ImageIcon(
                          AssetImage("assets/no.png"),
                          size: textScaleFactor * 20,
                          color: Colors.white,
                        ),
                        onPressed: () => setState(() => notifInfo.remove(notif)),
                      ),
                    ]
                  ),
                )
                : Container(//Playlist
                  color: MixTapeColors.dark_gray,
                  padding: EdgeInsets.all(9.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          softWrap: true,
                          style: TextStyle(
                            fontSize: (15 * textScaleFactor),
                            color: Colors.white,
                            fontFamily: "Montserrat",
                          ),
                        '${notif.user} invited you to join the playlist "${notif.title}" do you accept?'
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(10),
                        icon: ImageIcon(
                          AssetImage("assets/yes.png"),
                          size: textScaleFactor * 50,
                          color: Colors.white,
                        ),
                        onPressed: () => setState(() => notifInfo.remove(notif)),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(10),
                        icon: ImageIcon(
                          AssetImage("assets/no.png"),
                          size: textScaleFactor * 20,
                          color: Colors.white,
                        ),
                        onPressed: () => setState(() => notifInfo.remove(notif)),
                      ),
                    ]
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}