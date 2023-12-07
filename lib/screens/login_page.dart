import 'package:flutter/material.dart';
import 'package:mixtape/services/authentication_service.dart';
import 'package:mixtape/services/services_container.dart';
import 'package:mixtape/utilities/colors.dart';
import 'package:mixtape/screens/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String route = '/';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late AuthenticationService _authService;

  bool hasError = false;
  bool loading = false;
  String? errorMsg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final services = ServicesContainer.of(context);
    _authService = services.authService;
  }

  void onLogin() {
    toggleLoading();
    _authService.login().then(
          (success) {
        if (success) {
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          hasError = true;
        }
        print("this should work");
        return success; // Return the success value
      },
      onError: (err) {
        hasError = true;
        print("oh nooo");
        print(err);
        toggleLoading();
        return false; // Return a default value in case of an error
      },
    );
  }

  void toggleLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    return Scaffold(
        backgroundColor: MixTapeColors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * .2),
              Image.asset(
                'assets/green_colored_logo.png',
                width: screenHeight * .25,
                height: screenHeight * .25,
              ),
              SizedBox(height: screenHeight * .05),
              Text(
                "Welcome to",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: textScaleFactor * 17,
                ),
              ),
              SizedBox(height: screenHeight * .0091),
              Text(
                "MixTape",
                style: TextStyle(
                  letterSpacing: textScaleFactor * 1.2,
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  fontSize: textScaleFactor * 45,
                ),
              ),
              SizedBox(height: screenHeight * .055),
              !loading ? FilledButton.icon(
                onPressed: () {
                  print("login");
                  onLogin();

                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.all(10),
                  fixedSize: Size(screenWidth * .75, screenWidth * .25),
                ),
                icon: Image.asset(
                  'assets/spotify/Spotify_Icon_RGB_Green.png',
                  width: screenSize.shortestSide * .1,
                  height: screenSize.shortestSide * .1,
                  alignment: Alignment.centerLeft,
                ),
                label: Text(
                  'Login with Spotify',
                  style: TextStyle(
                    fontSize: 20 * textScaleFactor,
                    color: MixTapeColors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
              ) : CircularProgressIndicator(),
              if (hasError) ...[
                Text(errorMsg ?? 'Failed to login')
              ]
            ],
          ),
        ));
  }
}
