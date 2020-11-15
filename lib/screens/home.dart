import 'package:flutter/material.dart';
import 'package:kiosqs228/helpers/code_zone.dart';
import 'package:kiosqs228/helpers/data.dart';
import 'package:kiosqs228/models/Parution.dart';
import 'package:kiosqs228/models/agence.dart';
import 'package:kiosqs228/models/categorie.dart';
import 'package:kiosqs228/screens/Detail_photo.dart';
import 'package:kiosqs228/screens/Parution_tile.dart';
import 'package:kiosqs228/screens/categorie_tile.dart';
import 'package:kiosqs228/screens/emploi_page.dart';
import 'package:kiosqs228/screens/jobs.dart';
import 'package:kiosqs228/screens/news_page.dart';
import 'package:kiosqs228/screens/parutions_agence.dart';
import 'package:kiosqs228/screens/profile.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:twinkle_button/twinkle_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Categorie> categories = new List<Categorie>();
  List<Parution> parutions = new List<Parution>();
  List<Agence> agences = new List<Agence>();
  Future<List<Parution>> pars = null;
  KiosqsService kiosqsService = KiosqsService();
  bool _loading = true;
  int _selectedIndex = 0;
  String codeLecteur = "";
  int offset = 0;
  int limit = 3;
  ScrollController _scrollController = new ScrollController();
  getSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isPresent = prefs.getBool("isPresent");
    if (isPresent == null) isPresent = false;
    codeLecteur = prefs.getString("lecteurKey");
  }

  getData() {
    pars = kiosqsService.geAllParutionWithLimit(offset, limit);
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getSharedPreference();
    getData();

    _scrollController.addListener(() {
      //print(_scrollController.position.pixels);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print(offset);
        limit += 1;
        getData();
        setState(() {});
      }
    });
  }

  Future<List<Parution>> refresh() async {
    await Future.delayed(Duration(seconds: 2));
    return kiosqsService.geAllParutionWithLimit(offset, limit);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Container(
        width: MediaQuery.of(context).size.width * 2 / 3,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  // color: secondaryColor,
                  image: DecorationImage(
                    image: AssetImage('assets/images/c0.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          /*image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/images/p14.jpg'),
                            )*/
                        )),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: tertiaryColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(155.0),
                          bottomRight: Radius.circular(50.0))),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            FontAwesomeIcons.listAlt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                            text: " Listes des revues",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17)),
                      ],
                    ),
                  )),
              SingleChildScrollView(
                child: FutureBuilder(
                    future: kiosqsService.geAllAgence(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Agence>> snapshot) {
                      if (snapshot.hasData) {
                        agences = snapshot.data;
                        return ListView(
                            shrinkWrap: true,
                            // physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: agences
                                .map((Agence a) => agenceTile(a))
                                .toList());
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: tertiaryColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(155.0),
                          bottomRight: Radius.circular(50.0))),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            FontAwesomeIcons.infoCircle,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                            text: " Infos Pratiques",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17)),
                      ],
                    ),
                  )
                  //Text("Abonnement", style: TextStyle(color: Colors.white),),
                  ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    FontAwesomeIcons.commentAlt,
                                    size: 14,
                                    color: primaryColor,
                                  ),
                                ),
                                TextSpan(
                                    text: " A propos de nous",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          //  Navigator.pop(context);
                        },
                      ),
                      Divider(
                        color: tertiaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    FontAwesomeIcons.info,
                                    size: 14,
                                    color: primaryColor,
                                  ),
                                ),
                                TextSpan(
                                    text: "FAQs",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          //  Navigator.pop(context);
                        },
                      ),
                      Divider(
                        color: tertiaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    FontAwesomeIcons.lock,
                                    size: 14,
                                    color: primaryColor,
                                  ),
                                ),
                                TextSpan(
                                    text: " Deconnexion",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          //  Navigator.pop(context);
                        },
                      ),
                      Divider(
                        color: tertiaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "A la une des journaux du 228",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  //***Categories
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    height: 50,
                    child: ListView.builder(
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategorieTile(
                          imageUrl: categories[index].imageUrl,
                          categorieName: categories[index].name,
                          categorieid: categories[index].idcategorie,
                        );
                      },
                    ),
                  ),
                  //******blocs
                  Container(
                    height: MediaQuery.of(context).size.height / 7,
                    child: mySlide(),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TwinkleButton(
                        buttonTitle: Text(
                          'Les offres d\'emploi',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0,
                          ),
                        ),
                        buttonWidth: MediaQuery.of(context).size.width / 3,
                        buttonHeight: 30,
                        twinkleTime: 20,
                        durationTime: 5,
                        buttonColor: secondaryColor
                            .withOpacity(0.8), //Color(0xff3dce89),
                        onclickButtonFunction: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Jobs()));
                        },
                      ),
                      TwinkleButton(
                        buttonTitle: Text(
                          'Actualités du 228',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0,
                          ),
                        ),
                        buttonWidth: MediaQuery.of(context).size.width / 3,
                        buttonHeight: 30,
                        buttonColor:
                            primaryColor.withOpacity(0.8), //Color(0xff3dce89),
                        onclickButtonFunction: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NewsPage()));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  FutureBuilder(
                    future: pars, //kiosqsService.geAllParution(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Parution>> snapshot) {
                      if (snapshot.hasData) {
                        parutions = snapshot.data;
                        print(parutions[0].code);
                        return Expanded(
                          child: ListView(
                            controller: _scrollController,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: parutions
                                .map((Parution p) => ParutionTile(
                                      imageUrl: kiosqsService.BASE_URL_IMAGE +
                                          p.idparution.toString(),
                                      title: p.premierTitre ?? "",
                                      desc: p.descPremierTitre ?? "",
                                      agence: p.libelleAgence,
                                      p: p,
                                      codelecteur: codeLecteur,
                                    ))
                                .toList(),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
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
      ),
    );
  }

  Widget agenceTile(Agence agence) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          FontAwesomeIcons.newspaper,
                          size: 14,
                          color: primaryColor,
                        ),
                      ),
                      TextSpan(
                          text: "  " + agence.nom,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          )),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ParutionsAgence(agence: agence)),
                );
                //  Navigator.pop(context);
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

  Widget mySlide() {
    return ListView(
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height / 7,
            autoPlay: true,
            aspectRatio: 2.0,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 500),
            enlargeCenterPage: true,
            viewportFraction: 0.8,
          ),
          items: <Widget>[pub(), pub2(), pub3()],
        )
      ],
    );
  }

  Widget pub() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      height: MediaQuery.of(context).size.height / 7,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPhoto(
                        zoneCode.BASE_URL_IMAGE_pub + zoneCode.zone4)));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  zoneCode.BASE_URL_IMAGE_pub + zoneCode.zone4,
                  height: MediaQuery.of(context).size.height / 7,
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
      height: MediaQuery.of(context).size.height / 6,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPhoto(
                        zoneCode.BASE_URL_IMAGE_pub + zoneCode.zone5)));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  zoneCode.BASE_URL_IMAGE_pub + zoneCode.zone5,
                  height: MediaQuery.of(context).size.height / 6,
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

  Widget pub3() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      height: MediaQuery.of(context).size.height / 6,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPhoto(
                        zoneCode.BASE_URL_IMAGE_pub + zoneCode.zone6)));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  zoneCode.BASE_URL_IMAGE_pub + zoneCode.zone6,
                  height: MediaQuery.of(context).size.height / 6,
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
}
