import 'package:flutter/material.dart';
import 'package:kiosqs228/screens/home.dart';
import 'package:kiosqs228/screens/inscription.dart';
import 'package:kiosqs228/screens/publicite.dart';
import 'package:kiosqs228/screens/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String title="";
  String helper="";
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.subscribeToTopic('228kiosqs');
    _firebaseMessaging.configure(
      onMessage: (message)async{
        setState(() {
          title = message["notification"]["title"];
          print("notification title:"+title);
        });
      },
        onLaunch: (message)async{
          setState(() {
            title = message["notification"]["title"];
            print("notification launch:"+title);
          });
        },
      onResume: (message)async{
        setState(() {
          title = message["data"]["title"];
          print("notification resume title:"+title);
        });
        Navigator.pushReplacementNamed(context, '/home');
      }
    );
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        routes: {
          '/publicite': (context) => PublicitePage(),
           '/home':(context)=>HomePage(),
          '/inscrire':(context)=>InscriptionPage(),
        },
      debugShowCheckedModeBanner: false,
      title: '228KiosQs',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ScreenSplash(),
    );
  }
}
