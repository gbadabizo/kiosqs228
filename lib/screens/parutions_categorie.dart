import 'package:flutter/material.dart';
import 'package:kiosqs228/models/Parution.dart';
import 'package:kiosqs228/screens/Parution_tile.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParutionsCategorie extends StatefulWidget {
  String categorieName;
  int categorieid ;

  ParutionsCategorie({this.categorieName, this.categorieid});

  @override
  _ParutionsCategorieState createState() => _ParutionsCategorieState();
}

class _ParutionsCategorieState extends State<ParutionsCategorie> {

  List<Parution> parutions = new List<Parution>();

  Future<List<Parution>> pars = null;
  KiosqsService kiosqsService = KiosqsService();
  bool _loading = true;
  int _selectedIndex = 0;
  String codeLecteur = "";
  int offset = 0;
  int limit = 3;
  ScrollController _scrollController = new ScrollController();
  getSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isPresent = prefs.getBool("isPresent");
    if (isPresent == null) isPresent = false;
    codeLecteur = prefs.getString("lecteurKey");
  }

  getData() {
    pars = kiosqsService.geAllParutionByCategorie(widget.categorieid,offset, limit);
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();
    getSharedPreference();
    getData();
    _scrollController.addListener(() {
      //print(_scrollController.position.pixels);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print(offset);
        limit += 1;
        getData();
        setState(() {});
      }
    });
  }

  Future<List<Parution>> refresh() async {
    await Future.delayed(Duration(seconds: 2));
    return kiosqsService.geAllParutionWithLimit(offset, limit);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          ""+widget.categorieName,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              child: Column(
                children: <Widget>[

                  FutureBuilder(
                    future: pars, //kiosqsService.geAllParution(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Parution>> snapshot) {
                      if (snapshot.hasData) {
                        parutions = snapshot.data;
                        print(parutions[0].code);
                        return Expanded(
                          child: ListView(
                            controller: _scrollController,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: parutions
                                .map((Parution p) =>
                                ParutionTile(
                                  imageUrl: kiosqsService.BASE_URL_IMAGE +
                                      p.idparution.toString(),
                                  title: p.premierTitre ?? "",
                                  desc: p.descPremierTitre ?? "",
                                  agence: p.libelleAgence,
                                  p: p,
                                  codelecteur: codeLecteur,
                                ))
                                .toList(),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
