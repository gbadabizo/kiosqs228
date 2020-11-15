import 'package:flutter/material.dart';
import 'package:kiosqs228/models/Transaction.dart';
import 'package:kiosqs228/screens/home.dart';
import 'package:kiosqs228/screens/profile.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  int _selectedIndex = 1;
  KiosqsService kiosqsService = KiosqsService();
  List<Transaction> transactions;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
            child: Text(
          "Mes transactions",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Column(
          children: <Widget>[
          /*  FutureBuilder(
              future: ,
            )*/
          ],
        ),
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.home,
              size: 20,
              color: primaryColor,
            ),
            title: Text(
              'Accueil',
              style: TextStyle(color: tertiaryColor, fontSize: 16),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.list,
              size: 20,
              color: primaryColor,
            ),
            title: Text(
              'Transactions',
              style: TextStyle(color: tertiaryColor, fontSize: 16),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.hourglassHalf,
              size: 20,
              color: primaryColor,
            ),
            title: Text(
              'Abonnements',
              style: TextStyle(color: tertiaryColor, fontSize: 16),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.bell,
              size: 20,
              color: primaryColor,
            ),
            title: Text(
              'Notifications',
              style: TextStyle(color: tertiaryColor, fontSize: 16),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.userCircle,
              size: 20,
              color: primaryColor,
            ),
            title: Text(
              'Profil',
              style: TextStyle(color: tertiaryColor, fontSize: 16),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: secondaryColor,
        onTap: (_selectedIndex) {
          debugPrint("index du menu $_selectedIndex");
          if (_selectedIndex == 0) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomePage()));
          }
          if (_selectedIndex == 1) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => TransactionsPage()));
          }

          if (_selectedIndex == 4) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfilePage()));
          }
        },
      ),
    );
  }
}
