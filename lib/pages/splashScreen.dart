import 'dart:async';

import 'package:FaceNetAuthentication/constants/ui_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:FaceNetAuthentication/pages/home.dart';

import 'profile.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigate);
  }

  void navigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getBool('loggedIn'));
    print(prefs.getString('name'));
    if (prefs.getBool('loggedIn') == true) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return Profile(
          username: '',
        );
      }));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return MyHomePage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Image.asset(UIConstants.splashScreenLogo), Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text("Made with ❤ by Sayan Nath"),
          )],
        ),
      ),
    );
  }
}
