import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiosqs228/screens/data.dart';
import 'package:kiosqs228/screens/home.dart';
import 'package:kiosqs228/screens/jobs.dart';
import 'package:kiosqs228/screens/news_page.dart';
import 'package:kiosqs228/screens/profile.dart';
import 'package:kiosqs228/styleguide/colors.dart';

class EmploiPage extends StatefulWidget {
  @override
  _EmploiPageState createState() => _EmploiPageState();
}

class _EmploiPageState extends State<EmploiPage> {

 int _selectedIndex =2 ;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:
      AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: Jobs(),
      ),
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: primaryColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.home,
                size: 22,
                color: primaryColor,
              ),
              title: Text(
                'Accueil',
                style: TextStyle(color: Colors.black26, fontSize: 16),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.bullhorn,
                size: 22,
                color: primaryColor,
              ),
              title: Text(
                'Actualités',
                style: TextStyle(color: Colors.black26, fontSize: 16),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.briefcase,
                size: 22,
                color: primaryColor,
              ),
              title: Text(
                'Emplois',
                style: TextStyle(color: Colors.black26, fontSize: 16),
              ),
            ),

            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.userCircle,
                size: 22,
                color: primaryColor,
              ),
              // ignore: deprecated_member_use
              title: Text(
                'Profil',
                style: TextStyle(color: Colors.black26, fontSize: 16),
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
                  .push(MaterialPageRoute(builder: (context) => NewsPage()));
            }
            if (_selectedIndex == 2) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => EmploiPage()));
            }

            if (_selectedIndex == 3) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ProfilePage()));
            }
          },
        )
    );
  }




}
