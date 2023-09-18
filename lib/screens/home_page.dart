import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
        title: Text('Bottom Navigation Example'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tab 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Tab 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Tab 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Tab 4',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}