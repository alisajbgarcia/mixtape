import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Map<String, String>> cardData = [
    {
      'title': 'ish and charlie like to party',
      'image': 'assets/green_colored_logo.png',
    },
    {
      'title': 'group running playlist',
      'image': 'assets/blue_colored_logo.png',
    },
    {
      'title': 'trombone tunes',
      'image': 'assets/red_colored_logo.png',
    },
    // Add more data as needed
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Tab 1 Content'),
    Text('Tab 2 Content'),
    Text('Tab 3 Content'),
    Text('Tab 4 Content'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MixTapeColors.black,
      appBar: AppBar(
        title: Text('Your Playlists',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
        backgroundColor: MixTapeColors.black,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        toolbarHeight: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/blue_colored_logo.png'),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: cardData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 3.0,
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset(cardData[index]['image']!),
              title: Text(cardData[index]['title']!, style: TextStyle(fontSize: 20)),
              subtitle: Text(cardData[index]['image']!),
              onTap: () {
                // Handle card tap here
                print('Tapped on Card ${cardData[index]['title']}');
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: MixTapeColors.black, // Set the canvasColor to black
        ),
        child: BottomNavigationBar(
          backgroundColor: MixTapeColors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: MixTapeColors.green),
              label: 'Home'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add, color: MixTapeColors.green),
              label: 'Friends',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: MixTapeColors.green),
              label: 'Profile'
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: MixTapeColors.green,
          unselectedItemColor: MixTapeColors.green,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}