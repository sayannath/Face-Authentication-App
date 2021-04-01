import 'package:FaceNetAuthentication/db/database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:FaceNetAuthentication/constants/ui_constants.dart';


import 'home.dart';

class Profile extends StatefulWidget {
  const Profile({Key key, @required this.username}) : super(key: key);

  final String username;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DataBaseService _dataBaseService = DataBaseService();
  String name = '';

  @override
  void initState() {
    super.initState();
    savedStatus();
    getUsername();
  }

  savedStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', true);
    prefs.setString('name', widget.username);
  }

  getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (widget.username == null) {
      setState(() {
        name = prefs.getString('name').toString();
      });
    } else {
      setState(() {
        name = widget.username.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/home.png'),
            Text(
              'Welcome back, ' + name + '!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: UIConstants.fitToWidth(150, context),
              child: RaisedButton(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MyHomePage();
                  }), (Route<dynamic> route) => false);
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff25354E),
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
          _dataBaseService.cleanDB();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) {
            return MyHomePage();
          }), (Route<dynamic> route) => false);
        },
        child: Icon(Icons.delete),
      ),
    );
  }
}
