import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiosqs228/screens/Opaque_image.dart';
import 'package:kiosqs228/screens/emploi_page.dart';
import 'package:kiosqs228/screens/home.dart';
import 'package:kiosqs228/screens/my_info.dart';
import 'package:kiosqs228/screens/news_page.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:kiosqs228/styleguide/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3;
  bool isloading = true;

  String codeLecteur = "";
  Future getSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isPresent = prefs.getBool("isPresent");
    if (isPresent == null) isPresent = false;
    codeLecteur = prefs.getString("lecteurKey");

    return codeLecteur;
  }

  @override
  void initState() {
    super.initState();
    getSharedPreference().then((data) {
      setState(() {
        this.codeLecteur = data;
        this.isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        ),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Container(
                        color: primaryColor,
                        child: Stack(
                          children: <Widget>[
                            OpaqueImage("assets/images/p0.jpg"),
                            SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Mon Profil",
                                            textAlign: TextAlign.left,
                                            style: headingTextStyle,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: Icon(
                                              FontAwesomeIcons.pencilAlt,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    MyInfo(
                                      codeLecteur: codeLecteur,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(flex: 5, child: Container()),
                  ],
                )
              ],
            ),
    );
  }
}
