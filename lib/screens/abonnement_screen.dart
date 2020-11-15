import 'package:flutter/material.dart';
import 'package:kiosqs228/models/Abonnement.dart';
import 'package:kiosqs228/models/Reponse.dart';
import 'package:kiosqs228/screens/paycheck_abn.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:flutter/services.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AbonnementScreen extends StatefulWidget {
  int idagence ;

  AbonnementScreen({this.idagence});

  @override
  _AbonnementScreenState createState() => _AbonnementScreenState();
}

class _AbonnementScreenState extends State<AbonnementScreen> {
  int _radioValue = 0;
  List<Abonnement> abonnements = new List<Abonnement>();
  KiosqsService kiosqsService = KiosqsService();
  TextEditingController _textFieldController = TextEditingController();
  String codeLecteur="";
  getSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    codeLecteur = prefs.getString("lecteurKey");
  }
  void showToast(String msg, {int duration, int gravity,}) {
    Toast.show(msg, context, duration: duration, gravity: gravity, backgroundColor: tertiaryColor, textColor: Colors.white);
  }

  String telephone="";
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
                  if(telephone.isEmpty){
                    showToast("Veillez mettre le numero de telephone", duration: 3,
                      gravity: Toast.TOP, );
                  }else{
                    print(_radioValue);
                        if(method=="FLOOZ"){
                          Reponse r = await kiosqsService.sendPayAbn(telephone, _radioValue, codeLecteur);
                          if (r.code != null) {
                            if(r.code=="0"){
                              print(r.datas);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => PayCheckAbn(codetrans: r.datas,)),
                              );
                            }
                          }else{
                            showToast(" Echec veillez reessayer", duration: 4,
                              gravity: Toast.BOTTOM, );
                          }
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
  void initState() {
    getSharedPreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
        "Abonnement",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ))),
      body: SingleChildScrollView(
        child:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FutureBuilder(
                  future: kiosqsService.getAllAbonnmentByAgence(widget.idagence),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Abonnement>> snapshot) {
                    //  print(snapshot);
                    if (snapshot.hasData) {
                      abonnements = snapshot.data;
                      // print(abonnements.length);
                      return ListView(
                          shrinkWrap: true,
                          // physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          children: abonnements
                              .map((Abonnement a) => getRadioButton(a))
                              .toList());
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              SizedBox(
                height: 10.0,
              ),
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
                      if(_radioValue >0){
                        _displayDialog(context,"FLOOZ");
                      }else{
                        showToast("Choisissez un type d'abonnement", duration: 4,
                            gravity: Toast.CENTER, );
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
                      if(_radioValue >0){
                        _displayDialog(context,"T-MONEY");
                      }else{
                        showToast("Choisissez un type d'abonnement", duration: 4,
                          gravity: Toast.CENTER, );
                      }

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
                      if(_radioValue > 0){
                        _displayDialog2(context);
                      }else{
                        showToast("Choisissez un type d'abonnement", duration: 4,
                          gravity: Toast.CENTER, );
                      }

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
                  ),

                ],
              ),
              new Divider(height: 5,color: Colors.green,),
              Container(
                child:
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: new
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height /3,
                        decoration: new BoxDecoration(
                          //  shape: BoxShape.rectangle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new AssetImage('assets/images/c4.jpg'),
                            )
                        )
                    ),
                    /* Image.network(
                            kiosqsService.BASE_URL_IMAGE +
                                widget.p.idparution.toString(),
                            height: MediaQuery.of(context).size.height /6,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth,
                          )*/
                  ),

                ),
              ),
          ],),
        ),
      ),
    );
  }

  Widget getRadioButton(Abonnement abn) {
    return Row(
      children: <Widget>[
        new Radio(
            value: abn.idagabn,
            groupValue: _radioValue,
            onChanged: _handleRadioValueChange),
        new Text(
          abn.libabonnement +
              " ( Prix : " +
              abn.montant.round().toString() +
              " FCFA )",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
    });
  }
}
