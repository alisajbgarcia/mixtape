import 'package:flutter/material.dart';
import 'package:mixtape/main.dart';
import 'package:mixtape/services/authentication_service.dart';
import 'package:mixtape/services/friendship_service.dart';
import 'package:mixtape/services/playlist_service.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/widgets/navbar.dart';

import '../models/profile.dart';
import '../models/notification.dart';
import '../models/playlist.dart';
import '../utilities/navbar_pages.dart';
import '../services/services_container.dart';
import '../services/notification_service.dart';
import '../services/profile_service.dart';
import '../services/playlist_service.dart';
import 'playlist_page.dart';
import '../services/mixtape_service.dart';

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

  late Future<List<Notif>> notifs;
  late Future<Profile> currentProfile;
  late ProfileService profileService;
  late NotificationService notificationService;
  late AuthenticationService authenticationService;
  late PlaylistService playlistService;
  late FriendshipService friendshipService;
  late MixtapeService mixtapeService;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    String route = "/friends";
    switch (index) {
      case 0:
        route = '/home';
        break;
      case 1:
        route = '/friends';
        break;
      case 2:
        route = '/profile'; //don't migrate
    }
    Navigator.of(context).pushReplacementNamed(route);
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

  @override
  void initState() {
    super.initState();

    profileService = ServicesContainer.of(context).profileService;
    authenticationService = ServicesContainer.of(context).authService;
    notificationService = ServicesContainer.of(context).notificationService;
    playlistService = ServicesContainer.of(context).playlistService;
    friendshipService = ServicesContainer.of(context).friendshipService;
    mixtapeService = ServicesContainer.of(context).mixtapeService;


    setState(() {
      currentProfile = profileService.getCurrentProfile();
      notifs = notificationService.getNotifications();
    });
  }

  List<Notif> dummydata = [
    //Notif(id:'123', target: Profile('2', 'Zesty', 'Zesty', ''), externalId: '1', contents: 'NO NOTIFICATIONS!', notificationType: NotificationType.MIXTAPE),
  ];

  Future<void> _refresh() {
    setState(() {
      currentProfile = profileService.getCurrentProfile();
      notifs = notificationService.getNotifications();
    });
    return Future.delayed(Duration(seconds: 1));
  }


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
      
      body: FutureBuilder(
        future: notifs,
        builder: (context, notifSnapshot) {
          if (notifSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Display a loading indicator while waiting for data.
          } else {
            List<Notif> cardData;

            if(!notifSnapshot.hasData) {
              cardData = dummydata;

            } else {
              cardData = notifSnapshot.data!;
            }


            return RefreshIndicator(
              onRefresh: _refresh,
              color: MixTapeColors.green,
              backgroundColor: MixTapeColors.black,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: cardData.map((notif) {
                        return InkWell(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                  ),
                  margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: notif.notificationType == NotificationType.FRIENDSHIP && (filterValue.contains('Friend') || filterValue.contains('Off'))//Is it a friend or playlist notification
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
                            '${notif.contents}'
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
                                setState(() => cardData.remove(notif));
                                friendshipService.acceptRequest(notif.externalId);
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
                                setState(() => cardData.remove(notif));
                                friendshipService.deleteRequest(notif.externalId);
                                print('Friend Rejected');
                            }
                          ),
                        ]
                      ),
                    )
                    : notif.notificationType == NotificationType.PLAYLIST && (filterValue.contains('Playlist') || filterValue.contains('Off')) ? Container(//Playlist
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
                            notif.contents
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
                                setState(() => cardData.remove(notif));
                                playlistService.acceptRequest(notif.externalId);
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
                                setState(() => cardData.remove(notif));
                                playlistService.deleteRequest(notif.externalId);
                                print('Playlist Rejected');
                            }
                          ),
                        ]
                      ),
                    )
                    : notif.notificationType == (NotificationType.MIXTAPE) && (filterValue.contains('Activity') || filterValue.contains('Off')) ? Container(//Recent Activity
                      width: screenWidth * .9,
                      height: screenHeight * .07,
                      color: MixTapeColors.dark_gray,
                      //padding: EdgeInsets.only(top:9.0, bottom: 9, left: 0, right:0),
                      child: TextButton(
                          child: Text(
                            textAlign: TextAlign.start,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: (15 * textScaleFactor),
                              color: Colors.white,
                              fontFamily: "Montserrat",
                            ),
                          '${notif.contents}'
                          ),
                          onPressed: () async {
                            print('activity pressed');
                            Playlist playlist = await playlistService.getPlaylistForCurrentUser(notif.routingPath);
                            
                            Navigator.of(context).pushNamed('/playlist', arguments: ScreenArguments(playlist));
                          },
                        ),
                    ) : SizedBox()
                  ),
                ),
                        );
                      }).toList(),
                    ),
              ),
            ); } }
      ),
      bottomNavigationBar: NavBar(
        friendsPageKey: GlobalKey(),
        context: context,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}