import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiosqs228/helpers/code_zone.dart';
import 'package:kiosqs228/models/news.dart';
import 'package:kiosqs228/screens/Detail_photo.dart';
import 'package:kiosqs228/screens/emploi_page.dart';
import 'package:kiosqs228/screens/home.dart';
import 'package:kiosqs228/screens/profile.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:kiosqs228/widgets/event_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int _selectedIndex = 1;
  List<News> newss = [];
  KiosqsService kiosqsService = KiosqsService();
  Future<List<News>> futureNews;
  bool _loading = true;
  int offset = 0;
  int limit = 10;
  ScrollController _scrollController = new ScrollController();
  Future<List<News>> refreshNews() async {
    await Future.delayed(Duration(seconds: 2));
    return kiosqsService.getAllNews(offset, limit);
  }

  Future<List<News>> getNews() async {
    print("bonj");
    futureNews = kiosqsService.getAllNews(offset, limit);
    return futureNews;
  }

  @override
  void initState() {
    super.initState();
    getNews();
    _scrollController.addListener(() {
      // print(_scrollController.position.pixels);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //   print(offset);
        limit += 1;
        getNews();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Les actus du 228",
          style: TextStyle(color: Colors.white),
        )),
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
      body: RefreshIndicator(
        onRefresh: refreshNews,
        child: Stack(
          children: <Widget>[
            /* NewsPageBackground(
                screenHeight: MediaQuery.of(context).size.height,
              ),*/
            SafeArea(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: mySlide(),
                    ),
                    SizedBox(height: 5.0,),

                    /*   Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: Consumer<AppState>(
                          builder: (context, appState, _) => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[for (final category in categories) CategoryWidget(category: category)],
                            ),
                          ),
                        ),
                      ),*/
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(children: [
                        Container(
                          child: FutureBuilder(
                              future: futureNews,
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.hasData) {
                                  newss = snapshot.data;
                                  return ListView(
                                      shrinkWrap: true,
                                      physics: ClampingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      children: newss
                                          .map((News n) => EventWidget(n))
                                          .toList());
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ),
                      ]

                          // buildLastJobs(),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mySlide() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 4,
              autoPlay: true,
              aspectRatio: 2.0,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 500),
              enlargeCenterPage: true,
              viewportFraction: 0.8,
            ),
            items: <Widget>[pub(), pub2(), pub3()],
          ),
        )
      ],
    );
  }

  Widget pub() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      height: MediaQuery.of(context).size.height / 4,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => DetailPhoto(
                    zoneCode.BASE_URL_IMAGE_pub +zoneCode.zone7)));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                    zoneCode.BASE_URL_IMAGE_pub +zoneCode.zone7,
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
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPhoto(
                        zoneCode.BASE_URL_IMAGE_pub +zoneCode.zone8
                        )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  zoneCode.BASE_URL_IMAGE_pub +zoneCode.zone8,
                  height: MediaQuery.of(context).size.height / 4,
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
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPhoto(
                        zoneCode.BASE_URL_IMAGE_pub +zoneCode.zone9
                        )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  zoneCode.BASE_URL_IMAGE_pub +zoneCode.zone9,
                  height: MediaQuery.of(context).size.height / 4,
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
