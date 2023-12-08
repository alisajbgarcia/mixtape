import 'package:flutter/material.dart';
import 'package:mixtape/screens/add_songs.dart';
import 'package:mixtape/screens/approved_friends_page.dart';
import 'package:mixtape/screens/blocked_users_page.dart';
import 'package:mixtape/screens/friend_info_page.dart';
import 'package:mixtape/screens/home_page.dart';
import 'package:mixtape/screens/login_page.dart';
import 'package:mixtape/screens/notif_page.dart';
import 'package:mixtape/screens/playlist_creation.dart';
import 'package:mixtape/screens/search_page.dart';
import 'package:mixtape/screens/settings_page.dart';
import 'package:mixtape/screens/suggested_friends_page.dart';
import 'package:mixtape/screens/tape_creation.dart';
import 'package:mixtape/screens/tape_info_page.dart';
import 'package:mixtape/services/services_container.dart';

import 'models/mixtape.dart';
import 'models/playlist.dart';
import 'screens/friends_page.dart';
import 'screens/playlist_page.dart';
import 'screens/profile_page.dart';

void main() async {
  var services = await ServicesContainer.initialize();

  runApp(
    ServicesProvider(
      services: services,
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          late ScreenArguments args;
          WidgetBuilder builder;
          if (settings.arguments != null) {
            args = settings.arguments as ScreenArguments;
          }
          switch (settings.name) {
            case '/':
              builder = (BuildContext context) => const LoginPage();
              return MaterialPageRoute(builder: builder);
            case '/home':
              builder = (BuildContext context) => HomePage();
              return MaterialPageRoute(builder: builder);
            case '/friends':
              builder = (BuildContext context) => const FriendsPage();
              return MaterialPageRoute(builder: builder);
            case '/profile':
              builder = (BuildContext context) => const ProfilePage();
              return MaterialPageRoute(builder: builder);
            case '/playlist':
              builder = (BuildContext context) => PlaylistPage(playlist: args.playlist as Playlist);
              return MaterialPageRoute(builder: builder);
            case '/addsongs':
              builder = (BuildContext context) => AddSongsPage(playlist: args.playlist as Playlist, mixTapeName: args.mixTapeName as String, mixTapeDescription: args.mixTapeDescription as String);
              return MaterialPageRoute(builder: builder);
            case '/notifs':
              builder = (BuildContext context) => NotifPage();
              return MaterialPageRoute(builder: builder);
            case '/playlistcreate':
              builder = (BuildContext context) => const PlaylistCreationPage();
              return MaterialPageRoute(builder: builder);
            case '/search':
              builder = (BuildContext context) => const SearchPage();
              return MaterialPageRoute(builder: builder);
            case '/tape':
              builder = (BuildContext context) => TapeInfoPage(playlist: args.playlist as Playlist, mixtape: args.mixtape as Mixtape,);
              return MaterialPageRoute(builder: builder);
            case '/tapecreate':
              builder = (BuildContext context) => TapeCreationPage(playlist: args.playlist as Playlist);
              return MaterialPageRoute(builder: builder);
            case '/suggestedfriends':
              builder = (BuildContext context) => SuggestedFriendsPage();
              return MaterialPageRoute(builder: builder);
            case '/settings':
              builder = (BuildContext context) => SettingsPage();
              return MaterialPageRoute(builder: builder);
            case '/blockedusers':
              builder = (BuildContext context) => BlockedUsersPage();
              return MaterialPageRoute(builder: builder);
            case '/approvedusers':
              builder = (BuildContext context) => ApprovedFriendsPage();
              return MaterialPageRoute(builder: builder);
            case '/friendinfo':
              builder = (BuildContext context) => FriendInfoPage(friendId: args.friendId as String,);
              return MaterialPageRoute(builder: builder);
            default:
              throw Exception('Invalid route: ${settings.name}');
          }
        },
      ),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mixtape',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends LoginPage {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
}


//Arguments with routing
class ScreenArguments {
  final Playlist? playlist;
  final String? mixTapeName;
  final String? mixTapeDescription;
  final Mixtape? mixtape;
  final String? friendId;

  ScreenArguments([this.playlist, this.mixTapeName, this.mixTapeDescription, this.mixtape, this.friendId]);
}