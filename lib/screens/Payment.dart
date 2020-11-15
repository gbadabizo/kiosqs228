
import 'package:flutter/material.dart';
import 'package:kiosqs228/models/Parution.dart';
import 'package:kiosqs228/models/Reponse.dart';
import 'package:kiosqs228/screens/abonnement_screen.dart';
import 'package:kiosqs228/screens/paycheck.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:kiosqs228/styleguide/constants.dart';

class PaymentPage extends StatefulWidget {
  Parution p;
  String codeLecteur;
  PaymentPage({this.p, this.codeLecteur});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  KiosqsService kiosqsService = KiosqsService();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _textFieldController = TextEditingController();
  String telephone="";
  bool issuccess=false;
  final snackBar = SnackBar(
      content: Text(
        'Echec!!!, Réessayer le paiement ',
        style: kLabelStyle,
      ),);
  final snackBar2 = SnackBar(
    content: Text(
      'Paiement en cours patientez ou reéssayer ',
      style: kLabelStyle,
    ),
    backgroundColor: secondaryColor,
    duration: Duration(seconds: 5),
  );

  _displayDialog(BuildContext context, String method) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Paiement via '+method),
            content: TextField(
              controller: _textFieldController,
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(8),
                WhitelistingTextInputFormatter.digitsOnly,
                BlacklistingTextInputFormatter.singleLineFormatter,
              ],
              decoration: InputDecoration(hintText: "N° telephone"),
            ),
            actions: <Widget>[
              new FlatButton(
                color:   Colors.black26,
                child: new Text('Annuler',style: TextStyle(color: Colors.white,)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                color: Colors.green ,
                child: new Text('Envoyer',style: TextStyle(color: Colors.white,)),
                onPressed: () async {
                 telephone= _textFieldController.text;
                 print(telephone);
                    Reponse r = await kiosqsService.sendPay(telephone, widget.p.idparution, widget.codeLecteur);
                            if (r.code != null) {
                              if(r.code=="0"){
                                print(r.datas);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => PaycheckPage(idparution: widget.p.idparution,codeLecteur: widget.codeLecteur,)),
                                );
                              }else{
                                Scaffold.of(context).showSnackBar(snackBar);
                              }
                            }
                 // Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  _displayDialog2(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Paiement via PayPal'),
            content: Text("Des frais supplémentaires sont appliqués "),
            actions: <Widget>[
              new FlatButton(
                color:   Colors.black26,
                child: new Text('Annuler',style: TextStyle(color: Colors.white,)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                color: Colors.green ,
                child: new Text('Continuer',style: TextStyle(color: Colors.white,)),
                onPressed: () async {
                  telephone= _textFieldController.text;
                  print(telephone);

                  // Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Payer la revue",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: 
      Container(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(

            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                // alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(6),
                        bottomLeft: Radius.circular(6))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            kiosqsService.BASE_URL_IMAGE +
                                widget.p.idparution.toString(),
                            height: MediaQuery.of(context).size.height / 6,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth,
                          )
                      )
                      ,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[

                              Padding(
                                padding: const EdgeInsets.only(left:5.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(bottom: 5),
                                    decoration: new BoxDecoration(
                                      color: tertiaryColor,
                                    ),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          widget.p.libelleAgence,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                              ),

                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0),
                            child: Text(
                              widget.p.premierTitre,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:5.0),
                            child: Text(
                              widget.p.descPremierTitre,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: new BoxDecoration(
                    color: secondaryColor,
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text("Publié le : "+
                          (new DateFormat("dd-MM-yyyy").format(widget.p.dateParution)),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: new BoxDecoration(
                    color: tertiaryColor,
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text("Prix :"+widget.p.prixUnit.round().toString()+" FCFA"
                        ,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),
          ]
        ),
              new Divider(height: 5,color: Colors.green,),
              SizedBox(
                height: 8,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: new BoxDecoration(
                          color: Colors.green,
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text("Payer via "
                              ,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[

                        GestureDetector(
                          onTap: () async{
                            _displayDialog(context,"FLOOZ");
                            print(telephone);
                            if(telephone.length >0){

                            }

                          },
                          child: Padding(
                           padding: EdgeInsets.all(4),
                            child:Container(
                                width: MediaQuery.of(context).size.width/4,
                                height: 70.0,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new AssetImage('assets/images/logo-flooz.jpg'),
                                    )
                                )
                            ),
                       ),
                        ),

                        GestureDetector(
                          onTap: (){
                            _displayDialog(context,"T-MONEY");
                          },
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child:Container(
                                width: MediaQuery.of(context).size.width/4,
                                height: 60.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new AssetImage('assets/images/tmoney.jpg'),
                                    )
                                )
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            _displayDialog2(context,);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child:Container(
                                width: MediaQuery.of(context).size.width/4,
                                height: 60.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new AssetImage('assets/images/paypal.png'),
                                    )
                                )
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              new Divider(height: 5,color: Colors.green,),
              Padding(
                padding: const EdgeInsets.only(top:8.0),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){

                        },
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 5),
                            decoration: new BoxDecoration(
                              color: tertiaryColor,
                              borderRadius: new BorderRadius.circular(5),
                            ),

                            child: 
                            GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>AbonnementScreen(idagence: widget.p.idagence,)));
                              },
                              child: Align(
                                
                                alignment: Alignment.center,
                                child: Text("Abonnez vous à "+widget.p.libelleAgence
                                  ,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
          /*    Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height /6,
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(5),
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: new AssetImage(
                        "assets/images/p11.jpg",
                      ),
                    ),
                  ),
                ),
              ),

           */
              Expanded(
                  child:
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          kiosqsService.BASE_URL_IMAGE +
                              widget.p.idparution.toString(),
                          height: MediaQuery.of(context).size.height /6,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        )),
                  ),
                ),

            ],

          ),
        ),
      ),
    );
  }
}
