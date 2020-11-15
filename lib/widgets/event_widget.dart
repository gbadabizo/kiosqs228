import 'package:flutter/material.dart';
import 'package:kiosqs228/models/news.dart';
import 'package:kiosqs228/screens/Detail_photo.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EventWidget extends StatefulWidget {
  final News event;

  EventWidget(this.event);

  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  KiosqsService kiosqsService = KiosqsService();
  bool isPressed = false;
  Future<void> share(titre, content, url) async {
    await FlutterShare.share(
        title: titre,
        text: content,
        linkUrl: url,
        chooserTitle: 'Example Chooser Title');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            widget.event.urlImage1 != null
                ? mySlide()
                : ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    child:
                    Image.network(
                      kiosqsService.BASE_URL +
                          "parution/news/image/" +
                          widget.event.idnews.toString(),
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    )
                    /*Image.asset(
                  event.imagePath,
                  height: 200,
                  fit: BoxFit.fitWidth,
                ),*/
                    ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white70.withOpacity(0.7),
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new IconButton(
                                      icon: new Icon(isPressed
                                          ? Icons.favorite
                                          : FontAwesomeIcons.heart),
                                      color:
                                          isPressed ? Colors.red : Colors.black,
                                      onPressed: () {
                                        setState(() {
                                          isPressed = !isPressed;
                                        });
                                      },
                                    ),
                                    new SizedBox(
                                      width: 8.0,
                                    ),
                                    new IconButton(
                                      icon: new Icon(
                                        FontAwesomeIcons.share,
                                        color: primaryColor,

                                      ),
                                      color: primaryColor,
                                      onPressed: () {
                                       share(widget.event.titre, widget.event.contenu, widget.event.urlSource);
                                      },
                                    ),
                                  ],
                                ),
                                Row(children: <Widget>[
                                  Text("100 "),
                                  Icon(
                                    FontAwesomeIcons.heart,
                                    color: Colors.red,
                                  ),
                                ])
                              ],
                            ),
                            Divider(
                              height: 5.0,
                              color: secondaryColor,
                            ),
                            Text(
                              widget.event.titre,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: ReadMoreText(
                                      widget.event.contenu,
                                      trimLines: 4,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.justify,
                                      colorClickableText: tertiaryColor,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: '...voir plus',
                                      trimExpandedText: 'voir moins',
                                    ),

                                    /* Html(
                                        data: widget.event.contenu,
                                      )*/

                                    /*Text(
                                        event.contenu,
                                        maxLines: 4,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(color: Colors.black54, fontSize: 16),
                                      ),*/
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    padding: EdgeInsets.all(4),
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: new FlatButton(
                                      onPressed: () async {
                                        if (await canLaunch(
                                            widget.event.urlSource)) {
                                          await launch(widget.event.urlSource);
                                        } else {
                                          throw 'Could not launch ' +
                                              widget.event.urlSource;
                                        }
                                      },
                                      child: Text(widget.event.urlSource,
                                          //"lire la suite",
                                          style: TextStyle(
                                              color: Colors.black26,
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Divider(
              height: 4,
              color: primaryColor,
            )
          ],
        ),
      ),
    );
  }

  Widget mySlide() {
    List<Widget> listw = [];
    if (widget.event.urlImage != null) listw.add(slideWidget(0));
    if (widget.event.urlImage1 != null) listw.add(slideWidget(1));
    if (widget.event.urlImage2 != null) listw.add(slideWidget(2));
    if (widget.event.urlImage3 != null) listw.add(slideWidget(3));
    if (widget.event.urlImage4 != null) listw.add(slideWidget(4));
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height / 3,
                autoPlay: false,
                aspectRatio: 2.0,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 1000),
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
              items: listw,
            ),
          )
        ],
      ),
    );
  }

  Widget slideWidget(int numero) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 1, vertical: 2),
      height: MediaQuery.of(context).size.height / 3,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailPhoto(
                          kiosqsService.BASE_URL +
                              "parution/news/images/" +
                              widget.event.idnews.toString() +
                              "/" +
                              numero.toString(),
                        )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  kiosqsService.BASE_URL +
                      "parution/news/images/" +
                      widget.event.idnews.toString() +
                      "/" +
                      numero.toString(),
                  height: MediaQuery.of(context).size.height / 3,
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
