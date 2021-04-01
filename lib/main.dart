import 'package:FaceNetAuthentication/pages/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Face Auth using TF-Lite',
      theme: ThemeData(
        primaryColor: Color(0xff25354E),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonThemeData(
            buttonColor: Color(0xff25354E),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Color(0xff25354E)),
                borderRadius: BorderRadius.circular(25.0))),
      ),
      home: SplashScreen(),
    );
  }
}
