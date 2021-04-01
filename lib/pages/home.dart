import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:FaceNetAuthentication/constants/ui_constants.dart';
import 'package:FaceNetAuthentication/db/database.dart';
import 'package:FaceNetAuthentication/pages/sign-in.dart';
import 'package:FaceNetAuthentication/pages/sign-up.dart';
import 'package:FaceNetAuthentication/services/facenet.service.dart';
import 'package:FaceNetAuthentication/services/ml_vision_service.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Services injection
  FaceNetService _faceNetService = FaceNetService();
  MLVisionService _mlVisionService = MLVisionService();
  DataBaseService _dataBaseService = DataBaseService();

  CameraDescription cameraDescription;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _startUp();
  }

  /// 1 Obtain a list of the available cameras on the device.
  /// 2 loads the face net model
  _startUp() async {
    _setLoading(true);

    List<CameraDescription> cameras = await availableCameras();

    /// takes the front camera
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

    // start the services
    await _faceNetService.loadModel();
    await _dataBaseService.loadDB();
    _mlVisionService.initialize();

    _setLoading(false);
  }

  // shows or hides the circular progress indicator
  _setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Image.asset(UIConstants.tfLogo),
            )
          ],
        ),
        body: !loading
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text('Face Recognition System',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headline6
                                  .copyWith(
                                      fontSize: 23,
                                      color: Color(0xff25354E),
                                      fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'This app helps to\nAuthenticate Users by using\nFace Recognition',
                            style: TextStyle(color: Color(0xff878787)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Image.asset(
                          'assets/images/login.png',
                          height: UIConstants.fitToHeight(360, context),
                          width: UIConstants.fitToWidth(360, context),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.11,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: UIConstants.fitToWidth(100, context),
                              child: RaisedButton(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text('Sign In',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => SignIn(
                                        cameraDescription: cameraDescription,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: UIConstants.fitToWidth(100, context),
                              child: RaisedButton(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text('Sign Up',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => SignUp(
                                        cameraDescription: cameraDescription,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(0xff25354E),
                  ),
                ),
              ));
  }
}
