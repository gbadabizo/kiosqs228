import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:kiosqs228/styleguide/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScreenSplash extends StatefulWidget {
  @override
  _ScreenSplashState createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  bool isPresent = false;
  String code = "";
  bool internetStatus = true;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final snackBar = SnackBar(
    content: Text(
      'Erreur de connexion internet',
      style: kLabelStyle,
    ),
    backgroundColor: Colors.redAccent,
    duration: Duration(seconds: 5),
  );

  getSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isPresent = prefs.getBool("isPresent");
    if (isPresent == null) isPresent = false;
    print("ispresent:" + isPresent.toString());

    code = prefs.getString("lecteurKey");
    print("codeLecteur:" + code);
  }

  @override
  void initState() {
    getSharedPreference();
    super.initState();
    _checkInternetConnectivity();
  }

  getWait() {
    internetStatus = false;
    Timer(
        Duration(seconds: 4),
        () => {
              if (isPresent)
                //    {Navigator.pushReplacementNamed(context, '/home')}
                {Navigator.pushReplacementNamed(context, '/publicite')}
              else
                {Navigator.pushReplacementNamed(context, '/inscrire')}
            });
  }

  _checkInternetConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    print(result.toString());
    if (result == ConnectivityResult.none) {
    } else if (result == ConnectivityResult.mobile) {
      getWait();
    } else if (result == ConnectivityResult.wifi) {
      getWait();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        //  margin: EdgeInsets.only(top: 95.0),

                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: new BoxDecoration(
                            //shape: BoxShape.circle,
                            image: new DecorationImage(
                          //fit: BoxFit.fill,
                          image: new AssetImage(
                            "assets/images/logo2.png",
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
              ),
              internetStatus
                  ? Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                          ),
                          Text(
                            "L' infos dans  les kiosques du togo  ...",
                            style: TextStyle(
                                color: tertiaryColor,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )
                  : Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                                child: Text(
                              "Verifier votre connexion Internet !!!",
                              style: TextStyle(
                                  color: tertiaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                            Center(
                              child: RaisedButton.icon(
                                  color: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _checkInternetConnectivity();
                                    });
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.syncAlt,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Relancer",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          )
        ],
      ),
    );
  }
}
