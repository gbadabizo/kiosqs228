

class LecteurRequest{
  String nom ;
  String prenoms ;
  String telephone;

  LecteurRequest({this.nom, this.prenoms, this.telephone});
  Map tomap(){
    var map = new Map<String,dynamic>();
    map["nom"] = nom ;
    map["prenoms"]= prenoms;
    map["telephone"]= telephone;

    return map;
  }
  LecteurRequest.fromJson(Map<dynamic, dynamic> parseJson):
      nom =parseJson["nom"],
    prenoms=parseJson["prenoms"],
  telephone=parseJson["telephone"];
}