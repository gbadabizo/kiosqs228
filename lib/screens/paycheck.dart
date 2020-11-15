import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiosqs228/models/Reponse.dart';
import 'package:kiosqs228/screens/home.dart';
import 'package:kiosqs228/screens/parutionpdf.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:kiosqs228/styleguide/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class PaycheckPage extends StatefulWidget {
  int idparution;
  String codeLecteur;

  PaycheckPage({this.idparution, codeLecteur});

  @override
  _PaycheckPageState createState() => _PaycheckPageState();
}

class _PaycheckPageState extends State<PaycheckPage> {
  KiosqsService kiosqsService = KiosqsService();
  bool isloading = true;
  String code = "";
  void showToast(
    String msg, {
    int duration,
    int gravity,
  }) {
    Toast.show(msg, context,
        duration: duration,
        gravity: gravity,
        backgroundColor: Color(0xFF872954),
        textColor: Colors.white);
  }

  final snackBar = SnackBar(
    content: Text(
      'le paiement est effectué avec succès ',
      style: kLabelStyle,
    ),
    backgroundColor:  Color(0xFF872954),
    duration: Duration(seconds: 3),
  );
  final snackBar2 = SnackBar(
    content: Text(
      'le paiement est en cours ...',
      style: kLabelStyle,
    ),
  );
  checkpay2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("code" + code);
    code = prefs.getString("lecteurKey");
    Reponse rep = await kiosqsService.checkRevue(widget.idparution, code);
    print(rep.toString());
    if (rep != null) {
      if (rep.code == "800") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ParutionPdfPage(
              idparution: widget.idparution,
            )));
      }else{
        showToast("Le paiement  a échoué ou est en attente. Reéssayer plus tard ",
            duration: 5, gravity: Toast.BOTTOM);
        Navigator.pushReplacementNamed(context, '/home');
      }
    }else{
      showToast("Le paiement  a échoué ou est en attente. Reéssayer plus tard ",
          duration: 5, gravity: Toast.BOTTOM);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  checkpay() async {
    //  print("id"+widget.idparution.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("code" + code);
    code = prefs.getString("lecteurKey");
    Reponse rep = await kiosqsService.checkRevue(widget.idparution, code);
    print(rep.toString());
    if (rep != null) {
      if (rep.code == "800") {
        _showMyDialog();
      } else {
        isloading = false;
        setState(() {});
      }
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Paiement'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Paiement effectué avec succès'),
                Text('Bonne lecture'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Container(
                  decoration: new BoxDecoration(
                    color: primaryColor,
                    borderRadius: new BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'OK, Merci',
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ParutionPdfPage(
                          idparution: widget.idparution,
                        )));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 20), () => checkpay());
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(
            "Paiement en cours",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )),
        ),
        body: Center(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Text(
                  "Consulter vos sms ",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.redAccent),
                ),
              ),
              Center(
                child: Text(
                  "Paiement en cours patientez 30 secondes ",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.redAccent,
                  ),
                ),
              ),

              SizedBox(
                height: 10.0,
              ),
              isloading
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                      child: FlatButton(
                        color: secondaryColor,
                        textColor: Colors.white,
                        // disabledColor: Colors.grey,
                        //  disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(10.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          checkpay2();
                        },
                        child: Text(
                          "Verifer le paiement",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    )
            ],
          ),
        )),
      ),
      onWillPop: () {
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      },
    );
  }
}
