import 'package:flutter/material.dart';
import 'package:kiosqs228/models/Parution.dart';
import 'package:kiosqs228/models/Reponse.dart';
import 'package:kiosqs228/screens/Payment.dart';
import 'package:kiosqs228/screens/parutionpdf.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:kiosqs228/styleguide/constants.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_share/flutter_share.dart';
class ParutionTile extends StatefulWidget {
  String imageUrl, title, desc , agence , codelecteur;
  Parution p;

  ParutionTile({this.imageUrl, this.title,  this.desc, this.agence, this.p, this.codelecteur});

  @override
  _ParutionTileState createState() => _ParutionTileState();
}

class _ParutionTileState extends State<ParutionTile> {
  bool isPressed = false;

  KiosqsService kiosqsService = KiosqsService();
  Future<void> share(titre, content, url) async {
    await FlutterShare.share(
        title: titre,
        text: content,
        linkUrl: url,
        chooserTitle: 'Example Chooser Title');
  }
  final snackBar = SnackBar(
    content: Text(
      'Erreur !!!, vérifier votre connexion',
      style: kLabelStyle,
    ),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 5),
  );

  final snackBar2 = SnackBar(
    content: Text(
      'Erreur!!!, Identifer vous ',
      style: kLabelStyle,
    ),
    backgroundColor: Colors.red,
    duration: Duration(seconds: 5),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
       // print("CodeLecteur:"+this.codelecteur);
        if(widget.p.prixUnit==0){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ParutionPdfPage(idparution: widget.p.idparution,)));
        }else {
          if (this.widget.codelecteur.isNotEmpty) {
            Reponse r = await kiosqsService.checkRevue(
                this.widget.p.idparution, this.widget.codelecteur);
            if (r != null) {
              String code = r.code;
              if (code == "800") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        ParutionPdfPage(idparution: widget.p.idparution,)
                ));
              } else if (code == "804") {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        PaymentPage(p: this.widget.p, codeLecteur: widget.codelecteur,)
                ));
              }
            } else {
              Scaffold.of(context).showSnackBar(snackBar);
            }
          } else {
            Scaffold.of(context).showSnackBar(snackBar2);
          }
        }
      },
      child: Container(
          margin: EdgeInsets.only(bottom:2),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(4),
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: new BoxDecoration(
                      //borderRadius: new BorderRadius.circular(5),
                      color: tertiaryColor,
                    ),
                    child: Text(widget.agence, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight:FontWeight.bold),),
                  ),
                  ClipRRect(

                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        widget.imageUrl,
                        height: MediaQuery.of(context).size.height/3,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      )
                  ),
                  SizedBox(height: 12,),
                  Text(
                    widget.title,
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4,
                  ),
     /*       Row(
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
                        share(widget.p.premierTitre, widget.p.descPremierTitre, widget.agence+" N°"+widget.p.numParution);
                      },
                    ),
                  ],
                ),
            ],
          ),*/
                  Text(
                    widget.desc,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "publié le "+
                          (new DateFormat("dd-MM-yyyy").format(widget.p.dateParution)),
                      maxLines: 2,
                      style: TextStyle(color: Colors.black26, fontSize: 14 , fontStyle: FontStyle.italic),
                    ),
                  )

                ],
              ),
            ),
          )
      ),
    );
  }
}
