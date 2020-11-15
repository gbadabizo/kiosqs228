import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiosqs228/models/LecteurRequest.dart';
import 'package:kiosqs228/screens/radial_progress.dart';
import 'package:kiosqs228/screens/rounded_image.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:kiosqs228/styleguide/text_style.dart';

class MyInfo extends StatefulWidget {
  String  codeLecteur;

  MyInfo({this.codeLecteur});

  @override
  _MyInfoState createState() => _MyInfoState();
}

class _MyInfoState extends State<MyInfo> {
  KiosqsService kiosqsService= KiosqsService();
  LecteurRequest lecteurRequest = LecteurRequest();
  bool  isloading= true;
 Future getLecteur() async{
    lecteurRequest =  await kiosqsService.getLecteur(widget.codeLecteur);
  return lecteurRequest;
  }
  @override
  void initState() {
    super.initState();
    getLecteur().then((data){
     setState(() {
       this.lecteurRequest= data;
       this.isloading=false;
     });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RadialProgress(
            child: RoundedImage(
              imagePath: "assets/images/p0.jpg",
              size: Size.fromWidth(120.0),
            ),
          ),

          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            isloading? Center(child: CircularProgressIndicator(),)
                :  Text(lecteurRequest.nom+" "+lecteurRequest.prenoms, style: whiteNameTextStyle,),
             // Text(" Agoè Assiyéyé" ,style:  whiteSubHeadingTextStyle,)
            ],
          ),


        ],
      ),
    );
  }
}
