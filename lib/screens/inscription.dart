import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiosqs228/models/LecteurRequest.dart';
import 'package:kiosqs228/models/Reponse.dart';
import 'package:kiosqs228/screens/confirmation.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/country.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final nomformController = TextEditingController();
  final telformController = TextEditingController();
  final prenomsformController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String codephone="228";
  String codeLecteur="";
  String code="";
  KiosqsService kiosqsService = new KiosqsService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  bool isSignIn = false;
  bool isLoading= false ;

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation du numéro'),
          content: const Text(
              'Ce numero existe déja. Etes-vous le propriétaire?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Non'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('OUI'),
              onPressed: () async {
                print("CodeLecteur:"+codeLecteur);
                Reponse r = await kiosqsService.getsms(codeLecteur);
                if(r!=null){
                  code = r.datas.toString();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>ConfirmationPage(code,codeLecteur)
                  ));
                }
              },
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    nomformController.dispose();
    telformController.dispose();
   prenomsformController.dispose();

    super.dispose();
  }
  Widget _buildDropdownItem(Country country) => Container(
    child: Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        SizedBox(
          width: 8.0,
        ),
        Text("+${country.phoneCode}(${country.isoCode})"),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Center(
            child: Text(
          "Inscription à 228Kiosqs",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(3.0),
                child: new
                Container(
                    width:MediaQuery.of(context).size.height /3 ,
                    height: MediaQuery.of(context).size.height /4,
                    decoration: new BoxDecoration(
                       // shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/images/logo.png'),
                        )
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          controller: nomformController,
                          // maxLength: 25,
                          decoration: const InputDecoration(
                            labelText: 'Nom ',
                            hintText: 'Votre nom ',
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 18.0),
                            isDense: true,                      // Added this
                            contentPadding: EdgeInsets.all(13),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Veuillez saisir votre nom';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),

                        TextFormField(
                          // maxLength: 25,
                          controller: prenomsformController,
                          decoration: const InputDecoration(
                            labelText: 'Prénoms',
                            hintText: 'Votre prénom',
                            border: OutlineInputBorder(),
                            labelStyle:
                            TextStyle(color: Colors.black, fontSize: 18.0),
                            isDense: true,                      // Added this
                            contentPadding: EdgeInsets.all(13),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Veuillez saisir votre prénom';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(

                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                             SizedBox(

                                child: CountryPickerDropdown(
                                  initialValue: 'TG',
                                  itemBuilder: _buildDropdownItem,
                                //  itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                                  priorityList:[
                                    CountryPickerUtils.getCountryByIsoCode('GB'),
                                    CountryPickerUtils.getCountryByIsoCode('CN'),
                                  ],
                                  sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
                                  onValuePicked: (Country country) {
                                    print("Pays :${country.phoneCode}");
                                    codephone= country.phoneCode;
                                  },
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  // textAlign: TextAlign.center,
                                  controller: telformController,
                                  inputFormatters: <TextInputFormatter>[
                                    LengthLimitingTextInputFormatter(15),
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    BlacklistingTextInputFormatter.singleLineFormatter,
                                  ],
                                  keyboardType: TextInputType.phone,
                                  style: TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    labelText: 'N° Téléphone',
                                    hintText: 'votre numero de telephone',
                                    border: OutlineInputBorder(),
                                    labelStyle:
                                        TextStyle(color: Colors.black, fontSize: 15.0),
                                    isDense: true,                      // Added this
                                    contentPadding: EdgeInsets.all(13),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Veuillez saisir le numéro';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        RaisedButton(
                          elevation: 2.0,
                          onPressed: () async {

                            if (_formKey.currentState.validate()) {

                              LecteurRequest l = new LecteurRequest(
                                  nom: nomformController.text,
                                  telephone: codephone+""+telformController.text,
                                  prenoms: prenomsformController.text,
                                  );
                              setState(() {
                                isLoading=true;
                              });
                              Reponse rep = await kiosqsService
                                  .subscribeLecteur(
                                      body: l.tomap());
                              if (rep.code == '802') {
                                codeLecteur = rep.datas.toString();
                             _asyncConfirmDialog(context);

                              }else if (rep.code == '800') {
                                codeLecteur = rep.datas.toString();
                                print("codeLecteur:"+codeLecteur);
                                Reponse r = await kiosqsService.getsms(
                                    codeLecteur);
                                if (r != null) {
                                  code = r.datas.toString();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ConfirmationPage(
                                              code, codeLecteur)));
                                }
                              }
                            }
                          },
                          padding: EdgeInsets.all(10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: primaryColor,
                          child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.save,
                                size: 20,
                                color: Colors.white,
                              ),
                              Expanded(
                                child: Text(
                                  'Créer un compte',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                      fontSize: 23.0,
                                      fontFamily: 'OpenSans'),
                                ),
                              ),
                              Divider(height: 5.0,),
                              isLoading
                                  ? Center(
                                    child: CircularProgressIndicator(
                                backgroundColor: primaryColor,
                              ),
                                  )
                                  : Text(""),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        handleSignIn();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      highlightElevation: 3,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/google_logo.jpg"), height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Se connecter via gmail',
                style: TextStyle(
                  fontSize: 17.5,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _signInButtonFacebook() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      highlightElevation: 3,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/facebook_logo.png"), height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Se connecter via facebook',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;
    print(_user.displayName);

    setState(() {
      isSignIn = true;
    });
  }
}
