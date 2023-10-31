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
  bool isFilterVisible = false;
  String filterValue = 'Off';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => NavbarPages.navBarPages.elementAt(_selectedIndex)),
    );
  }

  void toggleFilter() {
      setState(() {
        isFilterVisible = !isFilterVisible;
      });
    }

  void filterSelect(String value) {
    setState(() {
      filterValue = value;
    });
  }

  List<NotifInfo> notifInfo = [
    NotifInfo('friend', 'alexfrey', ''),
    NotifInfo('playlist', 'charlie', 'Party Time'),
    NotifInfo('activity', 'alexfrey', '422 Blues'),
    NotifInfo('friend', 'bruh', ''),
    NotifInfo('activity', 'charlie', 'GOAT PLAYLIST')
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
        title: isFilterVisible ?
        Container(
          color: MixTapeColors.light_gray,
          alignment: Alignment.topLeft,
          margin:  EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 15),
          child: Row(
            
            children: [
              TextButton(
                onPressed: () {
                  filterSelect('Off');
                  toggleFilter();
                }, 
                child: Text('Off', style: TextStyle(color: Colors.white),)
              ),
              TextButton(
                onPressed: () {
                  filterSelect('Friends');
                  toggleFilter();
                }, 
                child: Text('Friends', style: TextStyle(color: Colors.white))
              ),
              TextButton(
                onPressed: () {
                  filterSelect('Playlists');
                  toggleFilter();
                }, 
                child: Text('Playlists', style: TextStyle(color: Colors.white))
              ),
              TextButton(
                onPressed: () {
                  filterSelect('Activity');
                  toggleFilter();
                }, 
                child: Text('Activity', style: TextStyle(color: Colors.white))
              ),
            ],
          )
          ) : Text('Notifications',
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
        leading: Column(
          children: [
            IconButton(
              icon: Icon(Icons.filter_alt_sharp),
              color: Colors.white,
              iconSize: textScaleFactor * 30,
              onPressed: () {
                toggleFilter();
              },
          ),
          ]
        ),
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
                child: notif.type.contains('friend') && (filterValue.contains('Friend') || filterValue.contains('Off'))//Is it a friend or playlist notification
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
                        onPressed: () {
                            setState(() => notifInfo.remove(notif));
                            print('Friend Accepted');
                        }
                      ),
                      IconButton(
                        padding: EdgeInsets.all(10),
                        icon: ImageIcon(
                          AssetImage("assets/no.png"),
                          size: textScaleFactor * 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                            setState(() => notifInfo.remove(notif));
                            print('Friend Rejected');
                        }
                      ),
                    ]
                  ),
                )
                : notif.type.contains('playlist') && (filterValue.contains('Playlist') || filterValue.contains('Off')) ? Container(//Playlist
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
                        onPressed: () {
                            setState(() => notifInfo.remove(notif));
                            print('Playlist Accepted');
                        }
                      ),
                      IconButton(
                        padding: EdgeInsets.all(10),
                        icon: ImageIcon(
                          AssetImage("assets/no.png"),
                          size: textScaleFactor * 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                            setState(() => notifInfo.remove(notif));
                            print('Playlist Rejected');
                        }
                      ),
                    ]
                  ),
                )
                : notif.type.contains('activity') && (filterValue.contains('Activity') || filterValue.contains('Off')) ? Container(//Recent Activity
                  width: screenWidth * .9,
                  height: screenHeight * .05,
                  color: MixTapeColors.dark_gray,
                  padding: EdgeInsets.only(top:9.0, bottom: 9, left: 0, right:0),
                  //child: Flexible(
                        child: Text(
                          textAlign: TextAlign.start,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: (15 * textScaleFactor),
                            color: Colors.white,
                            fontFamily: "Montserrat",
                          ),
                        '${notif.user} added a new tape to ${notif.title}'
                        ),
                   // ),
                ) : SizedBox()
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