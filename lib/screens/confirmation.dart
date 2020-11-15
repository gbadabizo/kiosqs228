
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiosqs228/models/Reponse.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:kiosqs228/styleguide/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ConfirmationPage extends StatelessWidget {
  var code;
  final String codeLecteur;
  KiosqsService kiosqsService= KiosqsService();


  ConfirmationPage(this.code, this.codeLecteur);
  //add connection to shared preference
  addToSF() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   print("code lecteur:"+codeLecteur);
   prefs.setString("lecteurKey", codeLecteur);
   prefs.setBool("isPresent", true);
  }
  final confirmController = TextEditingController();
  final snackBar = SnackBar(
    content: Text(
      'Code incorrect, réessayer',
      style: kLabelStyle,
    ),
    backgroundColor: Colors.green,
    duration: Duration(seconds: 5),
  );
  final snackBar2 = SnackBar(
    content: Text(
      'Erreur serveur, réessayer!!!',
      style: kLabelStyle,
    ),
    backgroundColor: tertiaryColor,
    duration: Duration(seconds: 5),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Confirmation du numero ", style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            new Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                width: 150.0,
                height: 150.0,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage('assets/images/p0.jpg'),
                    ))),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[

                      TextFormField(
                        // textAlign: TextAlign.center,
                        controller: confirmController,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(4),
                          WhitelistingTextInputFormatter.digitsOnly,
                          BlacklistingTextInputFormatter.singleLineFormatter,
                        ],
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          labelText: 'Code de confirmation SMS',
                          hintText: 'saisir le code de confirmation envoyé par sms',
                          border: OutlineInputBorder(),
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15.0),
                        ),
                      ),
                  SizedBox(
                    height: 10,
                  ),
                  Builder(
                    builder: (context) => RaisedButton(
                      elevation: 5.0,
                      onPressed: () async {
                        String codesaisie = confirmController.text;
                        print("code saisie: "+codesaisie);
                        print("code send: "+code.toString());
                        if (codesaisie.trim() == code.toString().trim()) {
                          Reponse rep = await kiosqsService.confirmCode( codeLecteur, code);
                          if(rep.code=="800"){
                            print("code lecteur:"+codeLecteur);
                            addToSF();
                            Navigator.pushReplacementNamed(context, "/home" );
                          }
                          else{
                            Scaffold.of(context).showSnackBar(snackBar2);
                          }
                        } else {
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      },
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.green,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.b,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.checkCircle,
                            size: 20,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Text(
                              'Valider',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                  fontSize: 23.0,
                                  fontFamily: 'OpenSans'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Code non reçu?",
                  style: TextStyle(fontSize: 18),
                ),
                FlatButton(

                  child: Text(
                    'Renvoyer le code',
                    style: TextStyle(fontSize: 18, color: Colors.redAccent),
                  ),
                  padding: const EdgeInsets.all(15),
                  onPressed: () async{
                    Reponse r = await kiosqsService.getsms( codeLecteur);
                      if(r!=null) {
                        code = r.datas.toString();
                      }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
