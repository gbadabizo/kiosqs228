import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kiosqs228/screens/emploi_page.dart';

import 'package:kiosqs228/screens/home.dart';
import 'package:kiosqs228/screens/news_page.dart';
import 'package:kiosqs228/screens/profile.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
class ParutionPdfPage extends StatefulWidget {
  int idparution;

  ParutionPdfPage({this.idparution});

  @override
  _ParutionPdfPageState createState() => _ParutionPdfPageState();
}


class _ParutionPdfPageState extends State<ParutionPdfPage> {

  String pathPDF ;
  String title="";
  String helper = "";
  KiosqsService kiosqsService= KiosqsService();
  bool _isLoading = true;
  PDFDocument document;
 int _selectedIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDocument();
  }
  loadDocument() async {
    document =  await PDFDocument.fromURL(kiosqsService.BASE_URL_PDF+ widget.idparution.toString());
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body:  Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
          document: document,
          zoomSteps: 1,
          //uncomment below line to preload all pages
          // lazyLoad: false,
          // uncomment below line to scroll vertically
          // scrollDirection: Axis.vertical,

          //uncomment below code to replace bottom navigation with your own
          /* navigationBuilder:
                      (context, page, totalPages, jumpToPage, animateToPage) {
                    return ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () {
                            jumpToPage()(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            animateToPage(page: page - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages - 1);
                          },
                        ),
                      ],
                    );
                  }, */
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
}
/*
class PDFScreen extends StatelessWidget {
  String pathPDF = "";
  PDFScreen(this.pathPDF);

  @override
  Widget build(BuildContext context) {
    return
      new WillPopScope(
        child: PDFViewerScaffold(
          appBar: AppBar(
            title: Text("Lire la revue - 228KIOSQS"),
            actions: <Widget>[
              /*IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              ),*/
            ],
          ),
          path: pathPDF),
        onWillPop: () {
     return     Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage()));
        },
      );
  }
}
 */
