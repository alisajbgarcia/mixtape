import 'package:flutter/material.dart';

import '../utilities/navbar_pages.dart';
import '../widgets/navbar.dart';

import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/widgets/navbar.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class FriendsInfo {
  String username;
  String image;

  FriendsInfo(this.username, this.image);
}

class _FriendsPageState extends State<FriendsPage> {
  bool isSearchBarVisible = false;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              NavbarPages.navBarPages.elementAt(_selectedIndex)),
    );
  }

  void toggleSearchBar() {
      setState(() {
        isSearchBarVisible = !isSearchBarVisible;
      });
    }

  List<FriendsInfo> cardData = [
    FriendsInfo('zestythomae', 'assets/green_colored_logo.png'),
    FriendsInfo('alisagarcia', 'assets/green_colored_logo.png'),
    FriendsInfo('joeypowers', 'assets/green_colored_logo.png'),
    FriendsInfo('charliesale', 'assets/green_colored_logo.png'),
    FriendsInfo('alexfrey', 'assets/green_colored_logo.png'),
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
        title: 
        Align(
          alignment: Alignment.center,
          child: Text('Your Friends',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w600,
              fontSize: (25.0 * textScaleFactor),
            ),
          ),
        ),
        backgroundColor: MixTapeColors.black,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        toolbarHeight: screenHeight * .13,
      ),
      body: Stack(
        children: [
          Container(
            height: screenHeight * .67,
            padding: EdgeInsets.fromLTRB(5, 0, 5, 30),
            child: SingleChildScrollView( // Use SingleChildScrollView instead of ListView
              child: Container(
                child: Column(
                  children: cardData.map((friend) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(12.0),
                      onTap: () {
                        print('Tapped on Friend ${friend.username}');
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                          ),
                          elevation: 3.0,
                          margin: EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    height: screenHeight * .07,
                                    color: MixTapeColors.dark_gray,
                                    child: Image.asset(friend.image),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
                                    height: screenHeight * .07,
                                    color: MixTapeColors.light_gray,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            friend.username,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: (22 * textScaleFactor),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Card(
                                          color: MixTapeColors.light_gray,
                                          elevation: 0.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          isSearchBarVisible
          ? Container(
            color: MixTapeColors.dark_gray,
            height: MediaQuery.of(context).size.height * 3/4,
            child: Center(
              child: isSearchBarVisible
                  ? Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: MixTapeColors.light_gray,
                              shape: CircleBorder(
                                side: BorderSide(color: MixTapeColors.light_gray),
                              ),
                            ),
                            child: Text(
                              style: const TextStyle(
                                              fontSize: (22),
                                              color: Colors.white,
                                            ),
                              'X',
                            ), 
                            onPressed: toggleSearchBar,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0, bottom: 5, left: 10, right: 10),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: MixTapeColors.dark_gray),
                              hintText: "Search for users...",
                              fillColor: Colors.white70,
                            ),
                          ),
                        ),
                        //TODO: Search bar results
                        
                      ],
                    )
                  : SizedBox() // Empty placeholder when not visible
            ),
          )
          : Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () { print('Tapped Added Friends'); },
              child: Container(
                //alignment: Alignment.bottomRight,
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: MixTapeColors.green,
                ),
                child: Center(
                  child:TextButton(
                    child: const Text(
                      'Add Friends +',
                      style: TextStyle(
                        fontSize: (22),                       
                        color: Colors.white,
                      ),
                      ),
                      onPressed: toggleSearchBar,
                    )
                  ),
                ),
              ),
            ),
         ],
       ),

      bottomNavigationBar: NavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
