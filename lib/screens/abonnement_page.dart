import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiosqs228/models/abonnement_tile.dart';
import 'package:kiosqs228/screens/Detail_photo.dart';
import 'package:kiosqs228/screens/home.dart';
import 'package:kiosqs228/screens/profile.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
class AbonnementPage extends StatefulWidget {
  @override
  _AbonnementPageState createState() => _AbonnementPageState();
}

class _AbonnementPageState extends State<AbonnementPage> {
  int _selectedIndex = 1;
  String codeLecteur = "";
  List<AbonnementTile> abns ;
  KiosqsService kiosqsService = KiosqsService();
  getSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isPresent = prefs.getBool("isPresent");
    if (isPresent == null) isPresent = false;
    codeLecteur = prefs.getString("lecteurKey");
  }
  Future<List<AbonnementTile>>_fetchAbn() async{
    return await kiosqsService.getAllAbonofLecteur(codeLecteur);
  }
  @override
  void initState() {
    super.initState();
   setState(() {
     getSharedPreference();
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Center(
            child: Text(
          "Mes abonnements",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Container(
                height: MediaQuery.of(context).size.height/7,
                child: mySlide(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: primaryColor,
                ),
              ),
        FutureBuilder(
            future: _fetchAbn(),
            builder: (BuildContext context,
                AsyncSnapshot<List<AbonnementTile>> snapshot) {
              if (snapshot.hasData) {
                abns = snapshot.data;
                return ListView(
                    shrinkWrap: true,
                    // physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: abns
                        .map((AbonnementTile a) => abnTile(a))
                        .toList());
              }else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
            ],
          ),
        ),
      ),
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
          /* BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.list,
              size: 20,
              color: primaryColor,
            ),
            title: Text(
              'Transactions',
              style: TextStyle(color: tertiaryColor, fontSize: 16),
            ),
          ),*/
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
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AbonnementPage()));
          }

          if (_selectedIndex == 3) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ProfilePage()));
          }
        },
      ),
    );
  }

  Widget abnTile(AbonnementTile ab) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Align(
                alignment: Alignment.topLeft,
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                FontAwesomeIcons.newspaper,
                                size: 18,
                                color: primaryColor,
                              ),
                            ),
                            TextSpan(
                                text: "jdsdsjjjqjqjqjj  " + ab.agence,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment.centerRight ,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: new BoxDecoration(
                            color: tertiaryColor,
                          ),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text("Du :"+ab.datedeb.toString()+" au " + ab.datefin
                                ,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {

              },
            ),
            Divider(
              color: tertiaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget mySlide(){
    return ListView(
      children: <Widget>[
        CarouselSlider(options:CarouselOptions(
          height: MediaQuery.of(context).size.height/7,
          autoPlay: true,
          aspectRatio: 2.0,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 500) ,
          enlargeCenterPage: true,
          viewportFraction: 0.8,
        ) ,
          items: <Widget>[
            pub(),
            pub2(),
            pub3()

          ],
        )

      ],
    );
  }
  Widget pub(){
    return   Container(
      margin:  EdgeInsets.symmetric(horizontal:1, vertical:5),
      height: MediaQuery.of(context).size.height/7,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height/7 ,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,

            ),
            child:  GestureDetector(
              onTap:(){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPhoto(
                      // "https://i2.wp.com/www.woodinfashion.com/wp-content/uploads/2019/10/4-1.jpg",
                      // "https://media.gettyimages.com/vectors/two-people-face-to-face-wearing-masks-2019ncov-virus-vector-id1203529885?s=2048x2048"
                        "https://www.moov.tg/sites/default/files/styles/content_banner/public/field/image_particulier/flooz_0.png?itok=zBWHqOFX"
                    )));
              } ,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  // "https://i2.wp.com/www.woodinfashion.com/wp-content/uploads/2019/10/4-1.jpg",
                  "https://www.moov.tg/sites/default/files/styles/content_banner/public/field/image_particulier/flooz_0.png?itok=zBWHqOFX",
                  //"https://media.gettyimages.com/vectors/two-people-face-to-face-wearing-masks-2019ncov-virus-vector-id1203529885?s=2048x2048",
                  height: MediaQuery.of(context).size.height/7,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),

              ),
            ),
          )
        ],
      ),
    );
  }
  Widget pub2() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      height: MediaQuery
          .of(context)
          .size
          .height / 6,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height /6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,

            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailPhoto(
                          // "https://i2.wp.com/www.woodinfashion.com/wp-content/uploads/2019/10/4-1.jpg",
                          //  "http://www.woodinfashion.com/wp-content/uploads/2015/04/Large-image1.jpg",
                          "http://kpatimanews.com/wp-content/uploads/2020/04/5e61230d3d959_consignes002.jpg",
                          // "https://www.togocel.tg/images/forfait-200.jpg",
                          // "https://media.gettyimages.com/vectors/two-people-face-to-face-wearing-masks-2019ncov-virus-vector-id1203529885?s=2048x2048"
                          //  "https://www.moov.tg/sites/default/files/styles/content_banner/public/field/image_particulier/flooz_0.png?itok=zBWHqOFX"
                        )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  //   "https://i2.wp.com/www.woodinfashion.com/wp-content/uploads/2019/10/4-1.jpg",
                  // "http://www.woodinfashion.com/wp-content/uploads/2015/04/Large-image1.jpg",
                  "http://kpatimanews.com/wp-content/uploads/2020/04/5e61230d3d959_consignes002.jpg",
                  // "https://www.togocel.tg/images/forfait-200.jpg",
                  //"https://www.moov.tg/sites/default/files/styles/content_banner/public/field/image_particulier/flooz_0.png?itok=zBWHqOFX",
                  //"https://media.gettyimages.com/vectors/two-people-face-to-face-wearing-masks-2019ncov-virus-vector-id1203529885?s=2048x2048",
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 6,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  fit: BoxFit.cover,
                ),

              ),
            ),
          )
        ],
      ),
    );
  }
  Widget pub3() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      height: MediaQuery
          .of(context)
          .size
          .height /6,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height /6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,

            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        DetailPhoto(
                          "https://i2.wp.com/www.woodinfashion.com/wp-content/uploads/2019/10/4-1.jpg",
                          //   "http://www.woodinfashion.com/wp-content/uploads/2015/04/Large-image1.jpg",
                          // "https://www.orabank.net/sites/default/files/styles/slideshow_1140_450/public/v1-slidershow_orabank-offre_entreprise.jpg?itok=jQAYt_RZ",
                          // "https://media.gettyimages.com/vectors/two-people-face-to-face-wearing-masks-2019ncov-virus-vector-id1203529885?s=2048x2048"
                          //   "https://www.moov.tg/sites/default/files/styles/content_banner/public/field/image_particulier/flooz_0.png?itok=zBWHqOFX"
                        )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  "https://i2.wp.com/www.woodinfashion.com/wp-content/uploads/2019/10/4-1.jpg",
                  // "http://www.woodinfashion.com/wp-content/uploads/2015/04/Large-image1.jpg",
                  // "https://www.orabank.net/sites/default/files/styles/slideshow_1140_450/public/v1-slidershow_orabank-offre_entreprise.jpg?itok=jQAYt_RZ",
                  // "https://www.moov.tg/sites/default/files/styles/content_banner/public/field/image_particulier/flooz_0.png?itok=zBWHqOFX",
                  //"https://media.gettyimages.com/vectors/two-people-face-to-face-wearing-masks-2019ncov-virus-vector-id1203529885?s=2048x2048",
                  height: MediaQuery
                      .of(context)
                      .size
                      .height /6,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  fit: BoxFit.cover,
                ),

              ),
            ),
          )
        ],
      ),
    );
  }
}
